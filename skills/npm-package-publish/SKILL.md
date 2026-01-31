---
name: npm-package-publish
description: 自动化发布 npm 包。包括升级版本号、根据最近提交生成 changelog 以及执行发布命令。当用户需要发布新版本时使用此 skill。
---

# npm-package-publish

此 skill 用于自动化 npm 包的发布流程。

## 流程指令

### 1. 准备工作
- 检查 `package.json` 中的当前版本号和 `private` 字段。
- 如果 `private` 为 `true`，提醒用户发布前需要将其修改为 `false` 或移除。
- 确认当前分支为发布分支（通常是 `main` 或 `master`）。

### 2. 确定版本升级类型
- 询问用户升级类型：`patch` (补丁), `minor` (次版本), `major` (主版本)。
- 如果用户未指定，默认建议 `patch`。

### 3. 生成 Changelog
- 获取自上一个版本（或上一个 tag）以来的所有提交记录：
  ```bash
  git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline
  ```
- 总结提交内容，并按照以下规范更新 `CHANGELOG.md`：
  - 如果项目中已有 `CHANGELOG.md`，遵循其现有格式。
  - 如果没有，则创建一个遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/) 规范的标准文件。

#### 标准 Changelog 模板：
```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [版本号] - YYYY-MM-DD
### Added
- 新增功能说明
### Changed
- 变更功能说明
### Fixed
- 修复问题说明
```

### 4. 执行发布
- 运行版本升级命令（这会自动创建 commit 和 tag）：
  ```bash
  npm version <patch|minor|major>
  ```
- 执行发布命令：
  ```bash
  npm publish
  ```
- 如果需要特定的 tag（如 `beta`），使用 `npm publish --tag beta`。

## 使用示例

### 示例 1：发布补丁版本
**用户输入**：发布一个新版本，修复了一些 bug。
**Agent 执行**：
1. 识别为 `patch` 升级。
2. 提取最近提交，例如 `fix: 修复了登录超时问题`。
3. 更新 `CHANGELOG.md`，在 `## [0.0.2] - 2026-01-31` 下添加 `### Fixed: 修复了登录超时问题`。
4. 执行 `npm version patch`。
5. 执行 `npm publish`。

### 示例 2：发布主版本
**用户输入**：我们要发布 1.0.0 版本了，重构了核心逻辑。
**Agent 执行**：
1. 识别为 `major` 升级。
2. 提取最近提交，例如 `feat!: 重构核心 API`。
3. 更新 `CHANGELOG.md`。
4. 执行 `npm version major`。
5. 执行 `npm publish`。

## 注意事项
- 确保在发布前已经执行了必要的构建步骤（如 `npm run build`）。
- 确保本地代码已全部提交且工作区干净。
- 如果发布失败，检查 npm 登录状态 (`npm whoami`)。
