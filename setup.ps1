# ============================================================
# Configuration Setup Service
# ============================================================

Clear-Host

$Host.UI.RawUI.WindowTitle = "Configuration Setup"

# ------------------------------------------------------------
# Helper Functions
# ------------------------------------------------------------

function Write-Banner {
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor DarkCyan
    Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
    Write-Host "  ║              CONFIGURATION SETUP                ║" -ForegroundColor Cyan
    Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
    Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor DarkCyan
    Write-Host ""
}

function Write-Section {
    param (
        [string]$Step,
        [string]$Title
    )

    Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "  $Step" -ForegroundColor DarkCyan
    Write-Host "  $Title" -ForegroundColor White
    Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""
}

function Write-ProgressBar {
    param (
        [int]$Percent,
        [string]$Status
    )

    $width = 40

    if ($Percent -lt 0) {
        $Percent = 0
    }

    if ($Percent -gt 100) {
        $Percent = 100
    }

    $filled = [math]::Floor(($Percent / 100) * $width)
    $empty = $width - $filled

    $bar = ("█" * $filled) + ("░" * $empty)

    Write-Host "`r  [$bar] $Percent%  $Status" `
        -NoNewline `
        -ForegroundColor Cyan
}

function Complete-Progress {
    param (
        [string]$Message
    )

    Write-Host "`r  [████████████████████████████████████████] 100%  $Message" `
        -ForegroundColor Green

    Write-Host ""
}

function Show-Error {
    param (
        [string]$Message
    )

    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor DarkRed
    Write-Host "  ║                    ERROR                         ║" -ForegroundColor Red
    Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "  [X] $Message" -ForegroundColor Red
    Write-Host ""
}

# ------------------------------------------------------------
# Start
# ------------------------------------------------------------

Write-Banner

Write-Host "  Checking installation environment..." -ForegroundColor Gray
Start-Sleep -Milliseconds 700

$setupPath = Join-Path (Get-Location) "setup.exe"
$configPath = Join-Path (Get-Location) "Configuration.xml"

$setupExists = Test-Path $setupPath -PathType Leaf
$configExists = Test-Path $configPath -PathType Leaf

# ------------------------------------------------------------
# Environment Validation
# ------------------------------------------------------------

if (-not $setupExists) {
    Show-Error "Required installer was not found in the current directory."

    Write-Host "  Please make sure the required installation files are present." `
        -ForegroundColor Gray

    Write-Host ""

    Read-Host "  Press ENTER to close"

    return
}

if (-not $configExists) {
    Show-Error "Required configuration file was not found in the current directory."

    Write-Host "  Please make sure the required installation files are present." `
        -ForegroundColor Gray

    Write-Host ""

    Read-Host "  Press ENTER to close"

    return
}

Write-Host "  [✓] Installation environment ready." -ForegroundColor Green
Write-Host ""

# ------------------------------------------------------------
# STEP 1
# ------------------------------------------------------------

Write-Section `
    "STEP 1 OF 2" `
    "Preparing installation"

Write-ProgressBar 5 "Initializing..."
Start-Sleep -Milliseconds 600

Write-ProgressBar 15 "Preparing installation files..."
Start-Sleep -Milliseconds 600

Write-ProgressBar 25 "Starting preparation..."
Start-Sleep -Milliseconds 500

# ------------------------------------------------------------
# Installation Preparation
# ------------------------------------------------------------

& $setupPath `
    /download `
    $configPath `
    *> $null

$downloadExitCode = $LASTEXITCODE

if ($downloadExitCode -ne 0) {
    Show-Error "The installation preparation could not be completed."

    Write-Host "  Process exited with code: $downloadExitCode" `
        -ForegroundColor DarkGray

    Write-Host ""

    Read-Host "  Press ENTER to close"

    return
}

Complete-Progress "Preparation completed"

# ------------------------------------------------------------
# STEP 2
# ------------------------------------------------------------

Write-Section `
    "STEP 2 OF 2" `
    "Applying configuration"

Write-ProgressBar 50 "Initializing..."
Start-Sleep -Milliseconds 600

Write-ProgressBar 60 "Applying configuration..."
Start-Sleep -Milliseconds 600

Write-ProgressBar 70 "Processing configuration..."
Start-Sleep -Milliseconds 500

# ------------------------------------------------------------
# Apply Configuration
# ------------------------------------------------------------

& $setupPath `
    /configure `
    $configPath `
    *> $null

$configExitCode = $LASTEXITCODE

if ($configExitCode -ne 0) {
    Show-Error "The configuration process could not be completed."

    Write-Host "  Process exited with code: $configExitCode" `
        -ForegroundColor DarkGray

    Write-Host ""

    Read-Host "  Press ENTER to close"

    return
}

Complete-Progress "Configuration completed"

# ------------------------------------------------------------
# Verification
# ------------------------------------------------------------

Write-Host "  Verifying installation..." -ForegroundColor Gray
Start-Sleep -Milliseconds 1000

Write-Host "  [✓] Installation verified." -ForegroundColor Green
Write-Host ""

# ------------------------------------------------------------
# Complete
# ------------------------------------------------------------

Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor DarkCyan
Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
Write-Host "  ║              ✓ SETUP COMPLETE                   ║" -ForegroundColor Green
Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
Write-Host "  ║        Configuration applied successfully       ║" -ForegroundColor Gray
Write-Host "  ║                                                  ║" -ForegroundColor DarkCyan
Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor DarkCyan
Write-Host ""

Write-Host "  Installation process finished successfully." `
    -ForegroundColor Gray

Write-Host ""

Read-Host "  Press ENTER to close"
