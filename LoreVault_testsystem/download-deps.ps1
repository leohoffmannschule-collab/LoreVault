# LoreVault - Abhaengigkeiten herunterladen (PowerShell)
# Funktioniert auf Windows 7, 8, 10, 11 - kein curl noetig

$Host.UI.RawUI.WindowTitle = "LoreVault - Download"

Write-Host ""
Write-Host "  LoreVault - Einmaliger Download aller Abhaengigkeiten" -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor DarkGray
Write-Host "  Dieser Vorgang ist nur EINMAL noetig." -ForegroundColor Gray
Write-Host "  Danach laeuft LoreVault vollstaendig offline." -ForegroundColor Gray
Write-Host ""

# TLS 1.2 erzwingen (noetig fuer aeltere Windows-Versionen)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Arbeitsverzeichnis = Ordner in dem das Script liegt
$base = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $base

$wc = New-Object System.Net.WebClient

function Download($step, $label, $url, $dest) {
    $fullDest = Join-Path $base $dest
    $dir = Split-Path $fullDest
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    Write-Host "  [$step] $label..." -ForegroundColor Yellow -NoNewline
    try {
        $wc.DownloadFile($url, $fullDest)
        Write-Host " OK" -ForegroundColor Green
    } catch {
        Write-Host " FEHLER: $_" -ForegroundColor Red
    }
}

Download "1/8" "PDF.js Bibliothek" `
    "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js" `
    "vendor\pdfjs\pdf.min.js"

Download "2/8" "PDF.js Worker" `
    "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js" `
    "vendor\pdfjs\pdf.worker.min.js"

Download "3/8" "Bootstrap Icons CSS" `
    "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" `
    "vendor\bootstrap-icons\bootstrap-icons.min.css"

Download "4/8" "Bootstrap Icons Schriftdatei woff2" `
    "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/fonts/bootstrap-icons.woff2" `
    "vendor\bootstrap-icons\fonts\bootstrap-icons.woff2"

Download "5/8" "Bootstrap Icons Schriftdatei woff" `
    "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/fonts/bootstrap-icons.woff" `
    "vendor\bootstrap-icons\fonts\bootstrap-icons.woff"

Download "6/8" "Schrift Playfair Display Regular" `
    "https://fonts.gstatic.com/s/playfairdisplay/v37/nuFiD-vYSZviVYUb_rj3ij__anPXDg.woff2" `
    "vendor\fonts\playfair\playfair-400.woff2"

Download "6/8" "Schrift Playfair Display Bold" `
    "https://fonts.gstatic.com/s/playfairdisplay/v37/nuFiD-vYSZviVYUb_rj3ij__anPXJTaQ.woff2" `
    "vendor\fonts\playfair\playfair-700.woff2"

Download "6/8" "Schrift Playfair Display Italic" `
    "https://fonts.gstatic.com/s/playfairdisplay/v37/nuFvD-vYSZviVYUb_rj3ij__anPXBYf9lW4.woff2" `
    "vendor\fonts\playfair\playfair-400i.woff2"

Download "7/8" "Schrift Crimson Pro 300" `
    "https://fonts.gstatic.com/s/crimsonpro/v24/q5uDsoa5M_tv7IihmnkabAReu49Y_Bo.woff2" `
    "vendor\fonts\crimson\crimson-300.woff2"

Download "7/8" "Schrift Crimson Pro 400" `
    "https://fonts.gstatic.com/s/crimsonpro/v24/q5uDsoa5M_tv7IihmnkabAReu49Y_Bo.woff2" `
    "vendor\fonts\crimson\crimson-400.woff2"

Download "7/8" "Schrift Crimson Pro 600" `
    "https://fonts.gstatic.com/s/crimsonpro/v24/q5uDsoa5M_tv7IihmnkabC5Au49Y_Bo.woff2" `
    "vendor\fonts\crimson\crimson-600.woff2"

Download "8/8" "Schrift JetBrains Mono 400" `
    "https://fonts.gstatic.com/s/jetbrainsmono/v18/tDbY2o-flEEny0FZhsfKu5WU4zr3E_BX0PnT8RD8yKxjPQ.woff2" `
    "vendor\fonts\jetbrains\jetbrains-400.woff2"

Download "8/8" "Schrift JetBrains Mono 500" `
    "https://fonts.gstatic.com/s/jetbrainsmono/v18/tDbY2o-flEEny0FZhsfKu5WU4zr3E_BX0PnT8RD8-KxjPQ.woff2" `
    "vendor\fonts\jetbrains\jetbrains-500.woff2"

Write-Host ""
Write-Host "  Schriftpfade in Bootstrap Icons CSS anpassen..." -ForegroundColor Yellow -NoNewline
$cssPath = Join-Path $base "vendor\bootstrap-icons\bootstrap-icons.min.css"
if (Test-Path $cssPath) {
    $css = Get-Content $cssPath -Raw
    $css = $css -replace '\.\./fonts/', 'fonts/'
    Set-Content $cssPath $css -Encoding UTF8
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " FEHLER: CSS nicht gefunden" -ForegroundColor Red
}

Write-Host ""
Write-Host "  ======================================================" -ForegroundColor DarkGray
Write-Host "  Alle Dateien heruntergeladen!" -ForegroundColor Green
Write-Host "  LoreVault laeuft jetzt vollstaendig offline." -ForegroundColor Green
Write-Host ""
Write-Host "  Naechster Schritt: start-server.bat doppelklicken" -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Druecke eine beliebige Taste zum Beenden..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
