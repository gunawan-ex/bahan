Clear-Host

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "       CONFIGURATION SETUP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Cek file
if (!(Test-Path ".\setup.exe")) {
    Write-Host "[X] setup.exe tidak ditemukan." -ForegroundColor Red
    Read-Host "Tekan ENTER untuk keluar"
    return
}

if (!(Test-Path ".\Configuration.xml")) {
    Write-Host "[X] Configuration.xml tidak ditemukan." -ForegroundColor Red
    Read-Host "Tekan ENTER untuk keluar"
    return
}

Write-Host "[+] Environment siap." -ForegroundColor Green
Write-Host ""

# Proses 1
Write-Host "[1/2] Menyiapkan instalasi..." -ForegroundColor Cyan

& ".\setup.exe" /download "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host "[X] Proses instalasi gagal." -ForegroundColor Red
    Read-Host "Tekan ENTER untuk keluar"
    return
}

Write-Host "[✓] Selesai." -ForegroundColor Green
Write-Host ""

# Proses 2
Write-Host "[2/2] Menerapkan konfigurasi..." -ForegroundColor Cyan

& ".\setup.exe" /configure "Configuration.xml" *> $null

if ($LASTEXITCODE -ne 0) {
    Write-Host "[X] Konfigurasi gagal." -ForegroundColor Red
    Read-Host "Tekan ENTER untuk keluar"
    return
}

Write-Host "[✓] Selesai." -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "          SETUP BERHASIL!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Read-Host "Tekan ENTER untuk keluar"
