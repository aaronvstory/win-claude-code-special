# Right-Click Launchers (Optional Power-User Feature)

Add Claude Code to your Windows Explorer right-click menu for easy launching from any folder!

## 🎯 What These Do

- Launch Claude Code from any folder via right-click menu
- Set up environment variables automatically
- Load API tokens from Windows registry or config
- Create MCP module junctions
- Enable Windows path translation
- Configure memory limits (32GB default)

## 📦 Files

- `claude-launcher.ps1` - Main launcher (new session)
- `claude-launcher-continue.ps1` - Continue mode (-c flag)
- `claude-launcher.bat` - Windows right-click wrapper for main
- `claude-launcher-continue.bat` - Windows right-click wrapper for continue

## 🚀 Setup Instructions

### Step 1: Customize the PowerShell Scripts

Edit BOTH `.ps1` files and update the config section at the top:

```powershell
# EDIT THESE IN BOTH FILES!

$NODE_MEMORY = 32768  # Memory in MB (32GB, 16GB, 8GB, etc.)

# Your API tokens (optional - leave blank to load from registry)
$MY_GITHUB_TOKEN = ""
$MY_BRAVE_API_KEY = ""
$MY_EXA_API_KEY = ""
$MY_PERPLEXITY_API_KEY = ""

# Other settings
$MY_PERPLEXITY_MODEL = "sonar"
$MY_ALLOWED_DIRECTORIES = "C:\,D:\,E:\"  # Your drive letters
```

### Step 2: Add to Windows Context Menu

#### Option A: Manual Registry Edit (Advanced)

1. Open Registry Editor (`regedit`)
2. Navigate to: `HKEY_CLASSES_ROOT\Directory\Background\shell`
3. Create new key: `ClaudeCode`
4. Set default value to: `Launch Claude Code Here`
5. Create subkey: `command`
6. Set command value to:
   ```
   "C:\full\path\to\claude-launcher.bat" "%V"
   ```

#### Option B: Quick PowerShell Script (Easier)

Run this in PowerShell **as Administrator**:

```powershell
# Change this to match your actual paths!
$launcherPath = "C:\path\to\your\claude-launcher.bat"
$continuePath = "C:\path\to\your\claude-launcher-continue.bat"

# Add main launcher
$regPath = "HKCR:\Directory\Background\shell\ClaudeCode"
New-Item -Path $regPath -Force
Set-ItemProperty -Path $regPath -Name "(Default)" -Value "Launch Claude Code Here"
New-Item -Path "$regPath\command" -Force
Set-ItemProperty -Path "$regPath\command" -Name "(Default)" -Value "`"$launcherPath`" `"%V`""

# Add continue launcher
$regPath2 = "HKCR:\Directory\Background\shell\ClaudeCodeContinue"
New-Item -Path $regPath2 -Force
Set-ItemProperty -Path $regPath2 -Name "(Default)" -Value "Launch Claude Code (Continue)"
New-Item -Path "$regPath2\command" -Force
Set-ItemProperty -Path "$regPath2\command" -Name "(Default)" -Value "`"$continuePath`" `"%V`""

Write-Host "✓ Added to context menu!"
```

### Step 3: Test It

1. Right-click in any folder (in empty space)
2. You should see "Launch Claude Code Here"
3. Click it - Claude Code launches in that folder!

## 🔧 Optional: Store API Tokens in Registry

Instead of editing the .ps1 files, you can store tokens in Windows registry:

```powershell
# Run in PowerShell
[System.Environment]::SetEnvironmentVariable("GITHUB_TOKEN", "your_token_here", "User")
[System.Environment]::SetEnvironmentVariable("EXA_API_KEY", "your_key_here", "User")
```

The launchers will automatically load these!

## 🐛 Troubleshooting

**"win-claude-code not found"**
- Run: `npm install -g win-claude-code`

**Right-click menu doesn't appear**
- Check your registry paths are correct
- Make sure .bat files have correct paths to .ps1 files
- Try logging out and back in

**PowerShell script doesn't run**
- Check execution policy: `Get-ExecutionPolicy`
- If restricted: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

**Scoop Git conflicts**
- The launchers automatically exclude Scoop Git (it's broken)
- Uses Program Files Git instead

## 🗑️ Uninstall

Remove from registry:
```powershell
Remove-Item "HKCR:\Directory\Background\shell\ClaudeCode" -Recurse
Remove-Item "HKCR:\Directory\Background\shell\ClaudeCodeContinue" -Recurse
```

Or just delete the registry keys manually in `regedit`.

## 💡 Advanced Features

- **Memory Tuning**: Adjust `$NODE_MEMORY` based on your RAM
- **Git Bash Integration**: Auto-detected if installed
- **MCP Junction**: Fixes MCP module path issues automatically
- **Permission Bypass**: Adds `--dangerously-skip-permissions` flag
- **Path Translation**: Windows → Unix path conversion

## 📝 Notes

- These are **optional** - win-claude-code works fine without them
- Backup your registry before editing
- Test in PowerShell before adding to context menu
- The `.bat` files are just wrappers that call the `.ps1` scripts
