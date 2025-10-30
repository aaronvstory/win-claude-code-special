@echo off
setlocal

:: ================================
:: Claude Code Continue Launcher (BAT wrapper)
:: ================================
:: IMPORTANT: Edit the path below!
:: ================================

for /f "delims=" %%I in ('where pwsh.exe 2^>nul') do set "PWSH=%%I"
if not defined PWSH set "PWSH=%ProgramFiles%\PowerShell\7\pwsh.exe"
if not exist "%PWSH%" set "PWSH=powershell.exe"

:: CUSTOMIZE THIS PATH!
set "LAUNCHER_SCRIPT=%~dp0claude-launcher-continue.ps1"

if not exist "%LAUNCHER_SCRIPT%" (
  echo ERROR: Launcher script not found!
  echo Looking for: %LAUNCHER_SCRIPT%
  echo.
  echo Please edit this .bat file and set the correct path.
  pause
  exit /b 1
)

"%PWSH%" -NoProfile -NoLogo -File "%LAUNCHER_SCRIPT%" "%~1"
