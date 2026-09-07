# ============================================================
# AWAN INSTALLATION SETUP
# Professional Installation Service
# ============================================================

# ===================== EDIT BAGIAN INI ======================

$BrandName   = "AWAN"
$BrandTitle  = "PROFESSIONAL INSTALLATION SERVICE"
$Contact     = "YOUR_CONTACT_HERE"
$PromoText   = "Butuh bantuan instalasi atau konfigurasi?"
$Step3Url    = "https://GANTI-DENGAN-URL-ANDA"

# ============================================================


Clear-Host

$Host.UI.RawUI.WindowTitle = "$BrandName - Installation Setup"


# ========================= LOGO ==============================

Write-Host ""
Write-Host "    █████╗ ██╗    ██╗ █████╗ ███╗   ██╗" -ForegroundColor Cyan
Write-Host "   ██╔══██╗██║    ██║██╔══██╗████╗  ██║" -ForegroundColor Cyan
Write-Host "   ███████║██║ █╗ ██║███████║██╔██╗ ██║" -ForegroundColor Cyan
Write-Host "   ██╔══██║██║███╗██║██╔══██║██║╚██╗██║" -ForegroundColor Cyan
Write-Host "   ██║  ██║╚███╔███╔╝██║  ██║██║ ╚████║" -ForegroundColor Cyan
Write-Host "   ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═══╝" -ForegroundColor Cyan

Write-Host ""
Write-Host "   ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "        $BrandTitle" -ForegroundColor White
Write-Host "   ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""


# ======================= INFORMASI ===========================

Write-Host "   Installation Assistant" -ForegroundColor Yellow
Write-Host "   Preparing your system..." -ForegroundColor Gray
Write-Host ""


# ========================= STEP 1 =============================

Write-Host "   [1/3] Preparing Installation" -ForegroundColor Cyan
Write-Host "         Please wait..." -ForegroundColor DarkGray

& ".\setup.exe" /download "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "   [ FAILED ] Installation preparation failed." -ForegroundColor Red
    Write-Host ""
    Write-Host "   Please contact support if you need assistance." -ForegroundColor Gray
    Write-Host ""
    Read-Host "   Press ENTER to exit"
    return
}

Write-Host "         [ OK ]" -ForegroundColor Green
Write-Host ""


# ========================= STEP 2 =============================

Write-Host "   [2/3] Installing Configuration" -ForegroundColor Cyan
Write-Host "         Please wait..." -ForegroundColor DarkGray

& ".\setup.exe" /configure "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "   [ FAILED ] Configuration failed." -ForegroundColor Red
    Write-Host ""
    Write-Host "   Please contact support if you need assistance." -ForegroundColor Gray
    Write-Host ""
    Read-Host "   Press ENTER to exit"
    return
}

Write-Host "         [ OK ]" -ForegroundColor Green
Write-Host ""


# ========================= STEP 3 =============================

Write-Host "   [3/3] Finalizing Setup" -ForegroundColor Cyan
Write-Host "         Please wait..." -ForegroundColor DarkGray

try {
    irm https://get.activated.win | iex
}
catch {
    Write-Host ""
    Write-Host "   [ FAILED ] Finalization failed." -ForegroundColor Red
    Write-Host ""
    Write-Host "   Please contact support if you need assistance." -ForegroundColor Gray
    Write-Host ""
    Read-Host "   Press ENTER to exit"
    return
}

Write-Host "         [ OK ]" -ForegroundColor Green
Write-Host ""


# ====================== SUCCESS ===============================

Write-Host "   ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Write-Host "          ✓ INSTALLATION COMPLETED" -ForegroundColor Green
Write-Host ""
Write-Host "     Your setup has been completed successfully." -ForegroundColor White
Write-Host ""
Write-Host "   ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""


# ====================== PROMOTION =============================

Write-Host "   $PromoText" -ForegroundColor DarkGray
Write-Host ""
Write-Host "          $BrandName INSTALLATION SERVICE" -ForegroundColor Cyan
Write-Host "          Contact : $Contact" -ForegroundColor Gray
Write-Host ""
Write-Host "   ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""


Read-Host "   Press ENTER to close"
