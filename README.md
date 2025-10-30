# win-claude-code-special

**One-command setup for Claude Code on Windows. No WSL needed.**

## 🚀 Setup (3 Steps)

```bash
# 1. Clone
git clone https://github.com/aaronvstory/win-claude-code-special.git
cd win-claude-code-special

# 2. Run setup
.\QUICK_SETUP.ps1

# 3. Restart PowerShell, then type:
claude
```

Done! 🎉

## 💡 What It Does

- Installs Claude Code + win-claude-code wrapper
- Sets up `claude` alias in PowerShell
- Enables Windows path conversion (`/mnt/c/` → `C:\`)
- Auto-detects Git Bash for Unix commands
- Fixes VS Code/Cursor IDE compatibility

## 📋 Requirements

- Windows 10/11
- Node.js 22+
- Git for Windows (optional - for grep, find, awk, sed)

## 🐛 Troubleshooting

**"Node.js not found"** → Install from https://nodejs.org

**"Git Bash not found" warning** → Optional. Install from https://git-scm.com/download/win

**Alias doesn't work** → Restart PowerShell completely

## 🙏 Credits

Fork of [somersby10ml/win-claude-code](https://github.com/somersby10ml/win-claude-code) with automated setup scripts.

## 📄 License

MIT
