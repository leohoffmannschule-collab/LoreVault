@echo off
chcp 65001 >nul
echo Starte PowerShell...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0download-deps.ps1"
echo.
echo Fertig. Druecke eine beliebige Taste zum Schliessen.
pause >nul
