@echo off
setlocal

:: ================================
:: Claude Code Right-Click Launcher (BAT wrapper)
:: ================================
:: IMPORTANT: Edit the path below to match where you saved the .ps1 file!
:: ================================

:: Find PowerShell 7 (or use PowerShell 5)
for /f "delims=" %%I in ('where pwsh.exe 2^>nul') do set "PWSH=%%I"
if not defined PWSH set "PWSH=%ProgramFiles%\PowerShell\7\pwsh.exe"
if not exist "%PWSH%" set "PWSH=powershell.exe"

:: CUSTOMIZE THIS PATH!
:: Update this to match where you saved claude-launcher.ps1
set "LAUNCHER_SCRIPT=%~dp0claude-launcher.ps1"

:: Check if launcher script exists
if not exist "%LAUNCHER_SCRIPT%" (
  echo ERROR: Launcher script not found!
  echo Looking for: %LAUNCHER_SCRIPT%
  echo.
  echo Please edit this .bat file and set the correct path.
  pause
  exit /b 1
)

:: Launch PowerShell script (Terminal will host PowerShell, not cmd)
:: %~1 passes the folder path from Explorer right-click
"%PWSH%" -NoProfile -NoLogo -File "%LAUNCHER_SCRIPT%" "%~1"
