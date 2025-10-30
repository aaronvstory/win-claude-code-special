param(
  [string]$TargetPath
)

# ================================
# Claude Code Continue Launcher
# ================================
# Launches Claude in "continue" mode (-c flag)
# CUSTOMIZE SETTINGS AT TOP OF FILE!
# ================================

$ErrorActionPreference = 'Stop'

# --------------------------------
# USER CONFIGURATION (EDIT THESE!)
# --------------------------------

# Memory allocation (in MB) - adjust based on your system
$NODE_MEMORY = 32768  # 32GB - change to 16384 (16GB) or 8192 (8GB) if needed

# Optional: Your API tokens (or leave blank to load from Windows registry)
$MY_GITHUB_TOKEN = ""
$MY_BRAVE_API_KEY = ""
$MY_EXA_API_KEY = ""
$MY_PERPLEXITY_API_KEY = ""

# Other configs
$MY_PERPLEXITY_MODEL = "sonar"
$MY_ALLOWED_DIRECTORIES = "C:\,D:\,E:\"

# --------------------------------
# Functions (same as main launcher)
# --------------------------------

function Write-Header($title) {
  Write-Host ('=' * 63)
  Write-Host ("   {0}" -f $title)
  Write-Host ('=' * 63)
  Write-Host
}

function Add-GitToPath {
  $candidates = @(
    "C:\Program Files\Git\usr\bin",
    "C:\Program Files\Git\bin"
  )
  foreach ($p in $candidates) {
    if (Test-Path $p) {
      if (-not ($env:PATH -split ';' | Where-Object { $_ -ieq $p })) {
        $env:PATH = $p + ';' + $env:PATH
      }
    }
  }
}

function Get-EnvFromRegistry([string]$Name) {
  try {
    $item = Get-ItemProperty -Path 'HKCU:\Environment' -ErrorAction Stop
    return ($item.$Name)
  } catch { return $null }
}

function Ensure-McpModuleJunction {
  $src = Join-Path $env:APPDATA 'npm\node_modules\@anthropic-ai\claude-code'
  $dst = Join-Path $HOME '.mcp-modules\node_modules\@anthropic-ai\claude-code'

  if (-not (Test-Path $src)) { return }

  $dstParent = Split-Path $dst -Parent
  if (-not (Test-Path $dstParent)) {
    New-Item -ItemType Directory -Path $dstParent | Out-Null
  }

  if (-not (Test-Path $dst)) {
    try {
      New-Item -ItemType Junction -Path $dst -Target $src | Out-Null
      Write-Host "  Fixed: MCP module path linked (junction)"
    } catch {
      Write-Host "  Note: Couldn't create junction (non-fatal): $($_.Exception.Message)"
    }
  }
}

# --------------------------------
# Main Script
# --------------------------------

if ($TargetPath -and (Test-Path $TargetPath)) {
  Set-Location -Path $TargetPath
}

Write-Header "CLAUDE CODE CONTINUE LAUNCHER"

# Environment setup
Write-Host "[ENVIRONMENT SETUP]"
$env:CLAUDE_FLOW_WINDOWS_TRANSLATION = "true"
$env:CLAUDE_FLOW_USE_POWERSHELL      = "true"
$env:CLAUDE_FLOW_HOOKS_ENABLED       = "true"
$env:CLAUDE_CODE_WINDOWS             = "true"

$env:MSYS_NO_PATHCONV        = "1"
$env:MSYS2_ARG_CONV_EXCL     = "*"
$env:MSYS2_PATH_TYPE         = "inherit"
$env:CYGWIN                  = "nodosfilewarning"
$env:MSYS_PATH_CONVERT_DISABLE = "1"
$env:MSYS2_ENV_CONV_EXCL     = "MSYS2_ARG_CONV_EXCL"

$env:BASH_DISABLE_TIMEOUT = "1"
$env:SHELL_NO_TIMEOUT     = "1"

$env:CLAUDE_DANGEROUSLY_SKIP_PERMISSIONS = "true"

# Load tokens
$tokens = @{
  'GITHUB_TOKEN' = $MY_GITHUB_TOKEN
  'BRAVE_API_KEY' = $MY_BRAVE_API_KEY
  'EXA_API_KEY' = $MY_EXA_API_KEY
  'PERPLEXITY_API_KEY' = $MY_PERPLEXITY_API_KEY
}

foreach ($key in $tokens.Keys) {
  $configValue = $tokens[$key]
  if ($configValue) {
    Set-Item "env:$key" -Value $configValue
  } elseif (-not (Test-Path "env:$key")) {
    $regValue = Get-EnvFromRegistry $key
    if ($regValue) { Set-Item "env:$key" -Value $regValue }
  }
}

if ($env:GITHUB_TOKEN) { $env:GITHUB_PERSONAL_ACCESS_TOKEN = $env:GITHUB_TOKEN }
$env:PERPLEXITY_MODEL      = $env:PERPLEXITY_MODEL      ?? $MY_PERPLEXITY_MODEL
$env:ALLOWED_DIRECTORIES   = $env:ALLOWED_DIRECTORIES   ?? $MY_ALLOWED_DIRECTORIES
$env:PYTHONIOENCODING      = "utf-8"
$env:PYTHONUNBUFFERED      = "1"

$env:CLAUDE_IMAGE_PATH_WINDOWS   = $env:TEMP
$env:CLAUDE_TRANSLATE_MACOS_PATHS = "true"
$env:CLAUDE_TEMP_PATH_OVERRIDE   = $env:TEMP

Add-GitToPath

Write-Host "  Translation: Windows path translation enabled"
Write-Host "  Permissions: Bypass enabled"
Write-Host "  Memory: ${NODE_MEMORY}MB heap"
Write-Host

$cli = Join-Path $env:APPDATA 'npm\node_modules\win-claude-code\runner.js'
if (-not (Test-Path $cli)) {
  Write-Host "[ERROR] win-claude-code not found."
  Write-Host "        Install with: npm install -g win-claude-code"
  exit 1
}

Ensure-McpModuleJunction

Write-Host
Write-Host "[DIRECTORY INFO]"
Write-Host ("  Windows Path: {0}" -f (Get-Location))
Write-Host

Write-Host "[LAUNCHING CLAUDE CODE - CONTINUE MODE]"
Write-Host ("  Command: node win-claude-code/runner.js --dangerously-skip-permissions -c")
Write-Host ("  Time:    {0}" -f (Get-Date))
Write-Host ('=' * 63)

# Run with -c (continue) flag
& node --max-old-space-size=$NODE_MEMORY $cli --dangerously-skip-permissions -c
$exitCode = $LASTEXITCODE

Write-Host
Write-Host ('=' * 63)
Write-Host "   CLAUDE CODE SESSION ENDED"
Write-Host ('=' * 63)
Write-Host ("  Exit Time: {0}" -f (Get-Date))
Write-Host

exit $exitCode
