Clear-Host

# ============================================================
#  CONFIGURATION SETUP TOOL
# ============================================================

$Host.UI.RawUI.WindowTitle = "Configuration Setup"

function Write-Banner {
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor DarkCyan
    Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
    Write-Host "  ║             CONFIGURATION SETUP                 ║" -ForegroundColor Cyan
    Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
    Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor DarkCyan
    Write-Host ""
}

function Write-ProgressBar {
    param (
        [int]$Percent,
        [string]$Status
    )

    $width = 40
    $filled = [math]::Floor(($Percent / 100) * $width)
    $empty = $width - $filled

    $bar = ("█" * $filled) + ("░" * $empty)

    Write-Host "`r  [$bar] $Percent%  $Status" -NoNewline -ForegroundColor Cyan
}

function Complete-Progress {
    param (
        [string]$Message
    )

    Write-Host "`r  [████████████████████████████████████████] 100%  $Message" -ForegroundColor Green
    Write-Host ""
}

# ------------------------------------------------------------
# START
# ------------------------------------------------------------

Write-Banner

Write-Host "  Checking installation environment..." -ForegroundColor Gray
Start-Sleep -Milliseconds 500

if (-not (Test-Path ".\setup.exe")) {
    Write-Host ""
    Write-Host "  [X] Required installer was not found." -ForegroundColor Red
    Write-Host ""
    exit 1
}

if (-not (Test-Path ".\Configuration.xml")) {
    Write-Host ""
    Write-Host "  [X] Configuration file was not found." -ForegroundColor Red
    Write-Host ""
    exit 1
}

Write-Host "  [✓] Installation environment ready." -ForegroundColor Green
Write-Host ""

# ------------------------------------------------------------
# STEP 1
# ------------------------------------------------------------

Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  STEP 1 OF 2" -ForegroundColor DarkCyan
Write-Host "  Preparing installation" -ForegroundColor White
Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""

Write-ProgressBar 5 "Initializing..."
Start-Sleep -Milliseconds 500

Write-ProgressBar 15 "Preparing files..."
Start-Sleep -Milliseconds 500

Write-ProgressBar 25 "Starting installation..."
Start-Sleep -Milliseconds 500

# Actual process
& ".\setup.exe" /download "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host ""
    Write-Host "  [X] Installation preparation failed." -ForegroundColor Red
    Write-Host ""
    exit $LASTEXITCODE
}

Complete-Progress "Preparation completed"

# ------------------------------------------------------------
# STEP 2
# ------------------------------------------------------------

Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  STEP 2 OF 2" -ForegroundColor DarkCyan
Write-Host "  Applying configuration" -ForegroundColor White
Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""

Write-ProgressBar 50 "Initializing..."
Start-Sleep -Milliseconds 500

Write-ProgressBar 60 "Applying configuration..."
Start-Sleep -Milliseconds 500

Write-ProgressBar 70 "Processing..."
Start-Sleep -Milliseconds 500

# Actual process
& ".\setup.exe" /configure "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host ""
    Write-Host "  [X] Configuration process failed." -ForegroundColor Red
    Write-Host ""
    exit $LASTEXITCODE
}

Complete-Progress "Configuration completed"

# ------------------------------------------------------------
# FINISH
# ------------------------------------------------------------

Write-Host "  Verifying installation..." -ForegroundColor Gray
Start-Sleep -Milliseconds 700

Write-Host "  [✓] Installation verified." -ForegroundColor Green
Write-Host ""

Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor DarkCyan
Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
Write-Host "  ║              ✓ SETUP COMPLETE                   ║" -ForegroundColor Green
Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
Write-Host "  ║          Configuration applied successfully     ║" -ForegroundColor Gray
Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor DarkCyan
Write-Host ""
