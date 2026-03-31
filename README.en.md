# open-claude

**🌐 Language / 语言：** **English** · [中文](./README.md)

> ⚠️ **For technical learning and research purposes only. Commercial use is strictly prohibited.**

---

## Background

On March 31, 2026, the core source code of **Claude Code** — Anthropic's AI coding assistant — was accidentally leaked and widely circulated in the developer community as obfuscated JavaScript.

Claude Code is a deeply terminal-integrated AI Coding Agent capable of file I/O, command execution, and multi-turn conversations, widely regarded as one of the most production-ready AI coding tools available. After the leak, many developers began studying and discussing its implementation.

**open-claude** is an experimental fork built on top of the leaked source:

- Replaced Anthropic's account-bound authentication with a **standard OpenAI-compatible API**
- Stripped Anthropic-internal proprietary dependencies so it runs in any public environment
- Added a first-launch onboarding flow for model selection, supporting any OpenAI-compatible API
- Preserved the full TUI experience (streaming output, tool calls, multi-file editing…)

The sole purpose of this project is to **study the engineering architecture of Claude Code** and explore adapting it to different LLM backends.

> All config files, logs, and session history are stored under `~/.open-claude/`. The executable is named `open-claude`. It **does not conflict** with the official `claude` command or `~/.claude/` directory — both can be installed simultaneously.

---

## Features

- Full terminal AI coding assistant experience
- Supports OpenAI and any OpenAI-compatible API (DeepSeek, Groq, local Ollama, etc.)
- First-launch onboarding: theme → **model selection** → security notice
- Switch models at runtime: `/model openai gpt-4o`
- Fully isolated from official Claude Code (`~/.open-claude/` vs `~/.claude/`)

---

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/THtianhao/open-claude/main/install.sh | bash
```

> Requires Git. The script installs [Bun](https://bun.sh) automatically if not present.

Then run:

```bash
open-claude
```

The first launch will guide you through model and API key setup.

---

## Manual Install

```bash
git clone https://github.com/THtianhao/open-claude.git ~/.open-claude-app
cd ~/.open-claude-app
bun install
ln -s ~/.open-claude-app/bin/open-claude ~/.local/bin/open-claude
```

---

## Configuration

### Option 1: First-launch onboarding (recommended)

Just run `open-claude` and follow the onboarding steps.

### Option 2: In-app commands

```
/model openai gpt-4o        # Switch model
/model key sk-...           # Set API key
/model baseurl https://...  # Set custom base URL (for DeepSeek, etc.)
```

### Option 3: Environment variables

```bash
export OPENAI_API_KEY=sk-...
export OPENAI_MODEL=gpt-4o
export OPENAI_BASE_URL=https://api.openai.com/v1   # optional
open-claude
```

---

## Uninstall

```bash
rm -f ~/.local/bin/open-claude
rm -rf ~/.open-claude-app
rm -rf ~/.open-claude
```

- `~/.local/bin/open-claude` — symlink
- `~/.open-claude-app/` — source directory
- `~/.open-claude/` — config & session history (optional to keep)

---

## Disclaimer

- This project is based on research of leaked Claude Code source and **does not represent Anthropic's official position**
- For personal learning and technical research only — **commercial use is prohibited**
- Users are solely responsible for any legal liability arising from use of this project

---

## License

This project follows the license terms of the original code. Please verify compliance before use.
