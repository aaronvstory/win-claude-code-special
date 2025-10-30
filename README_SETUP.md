# win-claude-code-special

**Enhanced Windows Setup with Custom Configurations**

This is a fork of [win-claude-code](https://github.com/somersby10ml/win-claude-code) with additional setup scripts and documentation for easier deployment.

## 🚀 Quick Start (3 Steps)

1. **Run the automated setup:**
   ```powershell
   .\QUICK_SETUP.ps1
   ```

2. **Restart PowerShell**

3. **Type:** `claude`

Done! 🎉

## 📦 What's Included

This package includes everything from the original win-claude-code plus:

- ✅ `QUICK_SETUP.ps1` - Automated installation script
- ✅ `INSTALLATION_GUIDE.md` - Comprehensive setup documentation
- ✅ `START_HERE.md` - Quick reference guide

## 💡 Features (from original win-claude-code)

- **Path Conversion** - Converts `/mnt/c/path` → `C:\path` automatically
- **Git Bash Integration** - Auto-detects and enables Unix commands
- **IDE Compatibility** - Works with VS Code/Cursor
- **F2 Key Support** - Plan mode toggle (Windows-compatible)
- **MCP Server Handling** - Proper Windows command wrapping

## 📝 Installation

### Method 1: Automated (Recommended)

```powershell
# Clone this repo
git clone https://github.com/aaronvstory/win-claude-code-special.git
cd win-claude-code-special

# Run setup
.\QUICK_SETUP.ps1
```

### Method 2: Manual

```bash
npm install -g @anthropic-ai/claude-code --ignore-scripts
npm install -g win-claude-code@1.0.8-canary.3
```

See `INSTALLATION_GUIDE.md` for detailed instructions.

## 🔧 Requirements

- Node.js 22+
- Windows 10/11
- Git for Windows (optional - for Unix commands)

## 📚 Documentation

- `START_HERE.md` - Quick start guide
- `INSTALLATION_GUIDE.md` - Full setup documentation
- `README.md` - Original documentation

## 🙏 Credits

This is a fork with enhanced setup scripts. All core functionality comes from the original [win-claude-code](https://github.com/somersby10ml/win-claude-code) project.

## 📄 License

MIT - See LICENSE file
