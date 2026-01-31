---
name: git-commit
description: 按照 AngularJS 规范自动生成并执行 git commit。适用于需要提交改动并保持 commit 历史整洁的场景。
---

# git-commit

此 skill 用于自动化生成符合 AngularJS 规范的 git commit 信息并执行提交。

## Commit 消息格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type (必需)
- **feat**: 新功能 (feature)
- **fix**: 修补 bug
- **docs**: 文档 (documentation)
- **style**: 格式 (不影响代码运行的变动)
- **refactor**: 重构 (即不是新增功能，也不是修改 bug 的代码变动)
- **perf**: 提高性能的改动
- **test**: 增加测试
- **chore**: 构建过程或辅助工具的变动
- **revert**: 回滚到上一个版本

### Scope (可选)
说明 commit 影响的范围，比如: `node_modules`, `utils`, `config`, `components` 等。

### Subject (必需)
commit 目的的简短描述，不超过 50 个字符。

### Body (可选)
对本次 commit 的详细描述，可以分成多行。

### Footer (可选)
如果是破坏性改动，以 `BREAKING CHANGE` 开头；如果是关闭 issue，可以使用 `Closes #123`。

## 流程指令

1. **分析改动**
   - 使用 `git status` 查看变更文件。
   - 使用 `git diff --cached` 查看已暂存的改动（如果已有暂存）。
   - 如果没有暂存改动，使用 `git diff` 查看未暂存的改动。

2. **生成消息**
   - 根据改动内容，确定 `type`、`scope` 和 `subject`。
   - 编写简洁明了的中文描述（或根据项目习惯使用英文）。

3. **执行提交**
   - 如果有未暂存的文件需要提交，先执行 `git add <files>`。
   - 执行 commit 命令：
     ```bash
     git commit -m "<type>(<scope>): <subject>" -m "<body>"
     ```

## 使用示例

### 示例 1：修复 Bug
**改动内容**：修复了登录页面验证码不显示的错误。
**生成消息**：
```bash
git commit -m "fix(auth): 修复验证码不显示的问题" -m "在 Login 组件中增加了对接口返回值的非空校验，确保验证码 URL 正确渲染。"
```

### 示例 2：新增功能
**改动内容**：在工具类中增加了一个日期格式化函数。
**生成消息**：
```bash
git commit -m "feat(utils): 增加 formatDate 工具函数" -m "支持 yyyy-MM-dd HH:mm:ss 格式转换，提升日期处理效率。"
```

## 注意事项
- 确保 commit 消息简洁且具有描述性。
- 尽量保持一次 commit 只做一件事情。
- 如果有 lint 错误，先修复再提交。
