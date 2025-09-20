# NeonShell Unregistration Script
# Run as Administrator

Write-Host "Unregistering NeonShell and restoring previous shell..." -ForegroundColor Cyan

try {
    # Restore backup shell
    $backupShell = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "ShellBackup" -ErrorAction SilentlyContinue
    if ($backupShell) {
        $backupValue = $backupShell.ShellBackup
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -Value $backupValue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "ShellBackup"
        Write-Host "Restored previous shell: $backupValue" -ForegroundColor Green
    } else {
        # Default to explorer if no backup
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -Value "explorer.exe"
        Write-Host "Restored default shell: explorer.exe" -ForegroundColor Green
    }
    
    Write-Host "NeonShell unregistered successfully!" -ForegroundColor Green
    Write-Host "Reboot your system to apply changes." -ForegroundColor Yellow
}
catch {
    Write-Host "Error unregistering shell: $_" -ForegroundColor Red
}

Pause
