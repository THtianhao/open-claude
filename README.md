# open-claude

**🌐 Language / 语言：** [English](./README.en.md) · **中文**

> 🙌 **更多模型正在接入中！欢迎提交需求 & PR，一起让 open-claude 支持更多 LLM！**
> 👉 [提交 Issue](https://github.com/THtianhao/open-claude/issues) · [提交 PR](https://github.com/THtianhao/open-claude/pulls)

---

> ⚠️ **本项目仅供技术交流与学习使用，请勿用于任何商业用途。**

---

## 背景

2026 年 3 月 31 日，Anthropic 旗下 AI 编程助手 **Claude Code** 的核心源码意外泄漏，以混淆 JavaScript 的形式在社区广泛流传。

这是一款深度集成在终端里的 AI Coding Agent，具备文件读写、命令执行、多轮对话等能力，被认为是目前工程完成度最高的 AI 编程工具之一。源码泄漏后，众多开发者开始对其实现细节进行研究和讨论。

这个项目（**open-claude**）是基于泄漏源码的学习性二次实验：

- 将原版与 Anthropic 账号强绑定的认证机制替换为**标准 OpenAI 兼容接口**
- 剥离 Anthropic 内部专有依赖，使其可在公开环境中独立运行
- 新增首次启动的模型选择引导，支持切换任意 OpenAI 兼容 API
- 保留完整的 TUI 交互体验（流式输出、工具调用、多文件编辑……）

本项目的唯一目的是**学习研究 Claude Code 的工程架构**，探索如何将其适配到不同的 LLM 后端。

> 所有配置文件、日志、会话记录均存储在 `~/.open-claude/` 目录下，可执行文件命名为 `open-claude`，与官方 `claude` 命令及 `~/.claude/` 目录**完全不冲突**，可同时安装使用。

---

## 功能

- 完整的终端 AI 编程助手体验
- 支持 OpenAI 及任意 OpenAI 兼容 API（如 DeepSeek、Groq、本地 Ollama 等）
- 首次启动引导：主题选择 → **模型选择** → 安全提示
- 运行时切换模型：`/model openai gpt-4o`
- 配置与官方 Claude Code 完全隔离（存储在 `~/.open-claude/`，不影响 `~/.claude/`）

---

## 快速安装

```bash
curl -fsSL https://raw.githubusercontent.com/THtianhao/open-claude/main/install.sh | bash
```

> 需要已安装 Git。脚本会自动安装 [Bun](https://bun.sh) 运行时。

安装完成后：

```bash
open-claude
```

首次启动会引导你选择模型并配置 API Key。

---

## 手动安装

```bash
git clone https://github.com/THtianhao/open-claude.git ~/.open-claude-app
cd ~/.open-claude-app
bun install
ln -s ~/.open-claude-app/bin/open-claude ~/.local/bin/open-claude
```

---

## 配置

### 方式一：首次启动引导（推荐）

直接运行 `open-claude`，按照 onboarding 步骤操作即可。

### 方式二：运行时命令

```
/model openai gpt-4o        # 切换模型
/model key sk-...           # 设置 API Key
/model baseurl https://...  # 设置自定义接口地址（兼容 DeepSeek 等）
```

### 方式三：环境变量

```bash
export OPENAI_API_KEY=sk-...
export OPENAI_MODEL=gpt-4o
export OPENAI_BASE_URL=https://api.openai.com/v1   # 可选
open-claude
```

---

## 卸载

```bash
rm -f ~/.local/bin/open-claude
rm -rf ~/.open-claude-app
rm -rf ~/.open-claude
```

- `~/.local/bin/open-claude` — 可执行软链
- `~/.open-claude-app/` — 源码目录
- `~/.open-claude/` — 配置与对话记录（可选保留）

---

## 声明

- 本项目基于对 Claude Code 源码的学习与研究，**不代表 Anthropic 官方立场**
- 仅供个人学习、技术交流使用，**禁止商业用途**
- 使用本项目产生的任何法律责任由使用者自行承担

---

## License

本项目遵循原始代码的许可条款。请在使用前确认合规性。
