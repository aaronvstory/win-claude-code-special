# win-claude-code Quick Setup
Write-Host "`n=== win-claude-code Setup ===" -ForegroundColor Cyan

# Check Node
Write-Host "`n[1/4] Checking Node.js..." -ForegroundColor Yellow
try {
    $v = node --version
    Write-Host "✓ Node.js: $v" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js not found! Install from: https://nodejs.org" -ForegroundColor Red
    exit 1
}

# Install Claude Code
Write-Host "`n[2/4] Installing Claude Code..." -ForegroundColor Yellow
npm install -g @anthropic-ai/claude-code --ignore-scripts
if ($LASTEXITCODE -eq 0) { Write-Host "✓ Installed" -ForegroundColor Green } else { exit 1 }

# Install win-claude-code
Write-Host "`n[3/4] Installing win-claude-code..." -ForegroundColor Yellow
npm install -g win-claude-code@1.0.8-canary.3
if ($LASTEXITCODE -eq 0) { Write-Host "✓ Installed" -ForegroundColor Green } else { exit 1 }

# Setup alias
Write-Host "`n[4/4] Setting up alias..." -ForegroundColor Yellow
$line = "function claude { win-claude-code @args }"
if (-not (Test-Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force | Out-Null }
$content = Get-Content $PROFILE -ErrorAction SilentlyContinue
if ($content -notcontains $line) {
    Add-Content -Path $PROFILE -Value "`n$line"
    Write-Host "✓ Alias added" -ForegroundColor Green
} else {
    Write-Host "✓ Alias exists" -ForegroundColor Green
}

Write-Host "`n=== Done! ===" -ForegroundColor Green
Write-Host "Restart PowerShell, then type: claude`n" -ForegroundColor Cyan
