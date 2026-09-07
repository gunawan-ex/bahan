Clear-Host

Write-Host ""
Write-Host "==================================================" -ForegroundColor DarkCyan
Write-Host "              CONFIGURATION SETUP" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor DarkCyan
Write-Host ""

Write-Host "[1/2] Preparing installation..." -ForegroundColor Yellow
Start-Sleep -Milliseconds 700

& ".\setup.exe" /download "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host "[X] Installation preparation failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "[+] Preparation completed." -ForegroundColor Green
Write-Host ""

Write-Host "[2/2] Applying configuration..." -ForegroundColor Yellow
Start-Sleep -Milliseconds 700

& ".\setup.exe" /configure "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host "[X] Configuration failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "[+] Configuration completed." -ForegroundColor Green
Write-Host ""

Write-Host "==================================================" -ForegroundColor DarkCyan
Write-Host "                 SETUP COMPLETE" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor DarkCyan
Write-Host ""
