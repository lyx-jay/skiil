---
name: skill-manager
description: 用于管理和安装本项目中的技能（skills）到各种开发工具（Cursor, VSCode, Claude 等）。
---

# skill-manager

此 skill 提供了一套通用的方式，将本仓库中的技能安装到不同的 AI 辅助开发工具中。

## 安装目标与方式

### 1. Cursor (项目级)
将技能复制到当前项目的 `.cursor/skills/` 目录，仅在该项目内生效。
```bash
./scripts/install.sh <skill-name> cursor-local
```

### 2. Cursor (全局)
将技能复制到系统的 `~/.cursor/skills/` 目录，在你电脑上的所有项目中生效。
```bash
./scripts/install.sh <skill-name> cursor-global
```

### 3. VSCode (GitHub Copilot)
将技能内容追加到 `.github/copilot-instructions.md` 中。
```bash
./scripts/install.sh <skill-name> vscode
```

### 4. Claude / 其他 Web Agent
由于 Web 端 Agent 通常没有本地目录，此模式会打印出技能的完整内容，方便你将其粘贴到 Claude 的项目指令（Project Instructions）或系统提示词中。
```bash
./scripts/install.sh <skill-name> print
```

## 开发者工作流

当你开发了一个新的技能并希望测试它时：
1. 运行 `./scripts/install.sh your-skill-name cursor-local`。
2. 在对话框中尝试调用它。
3. 修改 `skills/` 下的源文件后，需要再次运行安装命令以同步改动。

## 注意事项
- 在 Windows 环境下，建议使用 Git Bash 或 WSL 运行安装脚本。
- 如果目标工具支持 [MCP (Model Context Protocol)](https://modelcontextprotocol.io/)，未来我们将提供一个统一的 MCP Server 来动态加载这些技能。
