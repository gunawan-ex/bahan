$A="AWAN"
$B="PROFESSIONAL INSTALLATION SERVICE"
$C="YOUR_CONTACT_HERE"
$D="Need help with installation or configuration?"
$E="https://get.activated.win"
$F="QXdhbl9LZXk=.dat"

Clear-Host

Write-Host ""
Write-Host "     █████╗ ██╗    ██╗ █████╗ ███╗   ██╗"
Write-Host "    ██╔══██╗██║    ██║██╔══██╗████╗  ██║"
Write-Host "    ███████║██║ █╗ ██║███████║██╔██╗ ██║"
Write-Host "    ██╔══██║██║███╗██║██╔══██║██║╚██╗██║"
Write-Host "    ██║  ██║╚███╔███╔╝██║  ██║██║ ╚████║"
Write-Host "    ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═══╝"
Write-Host ""
Write-Host "    $B"
Write-Host ""

if (!(Test-Path ".\setup.exe") -or !(Test-Path ".\Configuration.xml")) {
    Write-Host "    Required files not found."
    Read-Host
    return
}

Write-Host "    [1/3] Processing..."
& ".\setup.exe" /download "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host "    Failed."
    Read-Host
    return
}

Write-Host "    [2/3] Processing..."
& ".\setup.exe" /configure "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host "    Failed."
    Read-Host
    return
}

Write-Host "    [3/3] Authorization"
Write-Host ""

if (!(Test-Path $F)) {
    Write-Host "    Authorization file not found."
    Read-Host
    return
}

$G=(Get-Content $F -Raw).Trim()
$H=Read-Host "    Password"

if ($H -ne $G) {
    Write-Host ""
    Write-Host "    Authorization failed."
    Read-Host
    return
}

Write-Host ""
Write-Host "    Processing..."
irm $E | iex

Remove-Item $F -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "    Installation completed."
Write-Host ""
Write-Host "    $D"
Write-Host "    $C"
Write-Host ""

Read-Host
