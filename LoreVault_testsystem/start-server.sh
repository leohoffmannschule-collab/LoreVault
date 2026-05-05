#!/bin/bash

echo ""
echo " ⬡  LoreVault – Lokaler Server"
echo " ================================"
echo ""

PORT=8000

# Prüfen ob Port belegt ist, dann nächsten freien suchen
while lsof -i :$PORT &>/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

URL="http://localhost:$PORT"

# Python 3 suchen
if command -v python3 &>/dev/null; then
    PY="python3"
elif command -v python &>/dev/null && python --version 2>&1 | grep -q "Python 3"; then
    PY="python"
else
    echo " [FEHLER] Python 3 wurde nicht gefunden."
    echo ""
    echo " Installation:"
    echo "   macOS:  brew install python3"
    echo "   Ubuntu: sudo apt install python3"
    echo ""
    exit 1
fi

echo " [OK] $PY gefunden. Starte Server auf $URL"
echo ""
echo " Öffne deinen Browser und gehe zu:"
echo " --> $URL"
echo ""
echo " Zum Beenden: Strg+C drücken"
echo ""

# Browser automatisch öffnen
if command -v open &>/dev/null; then
    sleep 1 && open "$URL" &   # macOS
elif command -v xdg-open &>/dev/null; then
    sleep 1 && xdg-open "$URL" &  # Linux
fi

$PY -m http.server $PORT
