---
name: npm-package-publish
description: 遵循业界标准（约定式提交）的自动化发布流程。包括前置检查、版本自动判定、Changelog 生成、版本发布及 Git 标签推送。
---

# npm-package-publish

此 skill 用于按照业界标准流程自动化发布 npm 包。它依赖于 **约定式提交 (Conventional Commits)** 规范来自动管理版本和日志。

## 流程指令

### 1. 预检与准备
- **环境检查**：
  - 确认 `package.json` 中 `private` 为 `false`。
  - 确认当前处于发布分支（`main` 或 `master`）。
- **状态检查**：确保本地工作区干净 (`git status`)。
- **质量保证**：建议运行 `npm test` 和 `npm run build`。

### 2. 版本判定 (基于提交规范)
- 获取自上一个 tag 以来的提交：
  ```bash
  git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline
  ```
- **判定规则**：
  - 若存在 `BREAKING CHANGE` 或提交类型后加 `!` (如 `feat!:`), 建议 `major`。
  - 若存在 `feat:`, 建议 `minor`。
  - 否则，建议 `patch`。
- 告知用户建议的版本升级类型并请求确认。

### 3. 生成 Changelog 与更新版本
1. **更新文件**：
   - 执行 `npm version <patch|minor|major> --no-git-tag-version`。
2. **更新 CHANGELOG.md**：
   - 提取提交信息，按类型（Features, Bug Fixes, Chores）分类。
   - 在 `CHANGELOG.md` 顶部插入新版本条目，格式遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。
   - 确保包含版本号和当前日期。

### 4. 提交发布变更
- 执行以下原子化操作：
  ```bash
  git add package.json package-lock.json CHANGELOG.md
  git commit -m "chore(release): v[新版本号]"
  git tag -a v[新版本号] -m "release v[新版本号]"
  ```

### 5. 推送与发布
- **推送远端**：`git push origin HEAD --follow-tags`。
- **执行发布**：`npm publish`（如需特定 tag，使用 `--tag`）。

## 使用示例

### 示例：发布包含新特性的版本
**用户输入**：我们要发个新版，加了用户搜索功能。
**Agent 执行**：
1. 检查工作区干净，运行并通过测试。
2. 分析提交发现 `feat: 增加用户搜索功能`，建议 `minor`。
3. 执行 `npm version minor --no-git-tag-version` (v1.1.0 -> v1.2.0)。
4. 更新 `CHANGELOG.md`，添加 `## [1.2.0] - 2026-01-31` 及其下的 `### Added` 内容。
5. 执行 `git add . && git commit -m "chore(release): v1.2.0" && git tag -a v1.2.0 -m "release v1.2.0"`。
6. 推送并执行 `npm publish`。

## 注意事项
- **约定式提交**：如果用户之前的提交不规范，Agent 应手动总结提交内容以确保 Changelog 的可读性。
- **OTP**：如果用户开启了两步验证，发布时会提示输入 OTP。
- **权限**：确保已执行过 `npm login`。
