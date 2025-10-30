# win-claude-code Installation Guide

This is win-claude-code v1.0.8-canary.3 - your complete Windows setup.

## What This Includes

**Windows-Specific Fixes:**
- ✅ Path conversion (WSL/POSIX `/mnt/c/` → Windows `C:\`)
- ✅ Git Bash integration for Unix commands
- ✅ VS Code/Cursor IDE compatibility
- ✅ F2 key remapping for plan mode
- ✅ Automatic bash detection

## Quick Install (3 Commands)

```bash
npm install -g @anthropic-ai/claude-code --ignore-scripts
npm install -g win-claude-code@1.0.8-canary.3
win-claude-code --version
```

## Setup PowerShell Alias

```powershell
# Open your profile
notepad $PROFILE

# Add this line:
function claude { win-claude-code @args }

# Reload:
. $PROFILE
```

Now type `claude` instead of `win-claude-code`!

## Requirements

- Node.js 22+
- Windows 10/11
- Git for Windows (optional - for Unix commands)

## VS Code Extension Path

Give them: `C:\Users\YourUsername\AppData\Roaming\npm\claude.cmd`

## Troubleshooting

**"Claude Code not found"**
```bash
npm install -g @anthropic-ai/claude-code --ignore-scripts
```

**Git Bash warning** - Install from: https://git-scm.com/download/win

**MCP Server warning** - Use `cmd /c npx` instead of just `npx`

## Support

- GitHub: https://github.com/somersby10ml/win-claude-code
- Issues: https://github.com/somersby10ml/win-claude-code/issues
