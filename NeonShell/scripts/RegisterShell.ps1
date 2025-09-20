# NeonShell Registration Script
# Run as Administrator

Write-Host "Registering NeonShell as default shell..." -ForegroundColor Cyan

try {
    # Backup current shell
    $currentShell = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -ErrorAction SilentlyContinue
    if ($currentShell) {
        $backupValue = $currentShell.Shell
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "ShellBackup" -Value $backupValue
        Write-Host "Backed up current shell: $backupValue" -ForegroundColor Green
    }

    # Set NeonShell as new shell
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -Value "NeonShell.exe"
    Write-Host "NeonShell registered successfully!" -ForegroundColor Green
    Write-Host "Reboot your system to apply changes." -ForegroundColor Yellow
}
catch {
    Write-Host "Error registering shell: $_" -ForegroundColor Red
}

Pause
