@echo off
chcp 65001 >nul
title LoreVault – Lokaler Server

echo.
echo  ⬡  LoreVault – Lokaler Server
echo  ================================
echo.

:: Python 3 verfügbar?
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo  [OK] Python gefunden. Starte Server auf http://localhost:8000
    echo.
    echo  Oeffne jetzt deinen Browser und gehe zu:
    echo  --^> http://localhost:8000
    echo.
    echo  Zum Beenden: Strg+C druecken
    echo.
    start "" "http://localhost:8000"
    python -m http.server 8000
    goto end
)

:: Python als python3?
python3 --version >nul 2>&1
if %errorlevel% == 0 (
    echo  [OK] Python3 gefunden. Starte Server auf http://localhost:8000
    echo.
    start "" "http://localhost:8000"
    python3 -m http.server 8000
    goto end
)

echo  [FEHLER] Python wurde nicht gefunden!
echo.
echo  Bitte installiere Python von: https://www.python.org/downloads/
echo  Stelle sicher, dass "Add Python to PATH" angehaket ist.
echo.
pause

:end
