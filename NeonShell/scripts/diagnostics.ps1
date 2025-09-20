# NeonShell Diagnostics Script

Write-Host "NeonShell Diagnostics" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "[OK] Running as Administrator" -ForegroundColor Green
} else {
    Write-Host "[WARN] Not running as Administrator" -ForegroundColor Yellow
}

# Check current shell
try {
    $currentShell = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell"
    Write-Host "[INFO] Current Shell: $($currentShell.Shell)" -ForegroundColor Cyan
    
    $backupShell = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "ShellBackup" -ErrorAction SilentlyContinue
    if ($backupShell) {
        Write-Host "[INFO] Backup Shell: $($backupShell.ShellBackup)" -ForegroundColor Cyan
    }
} catch {
    Write-Host "[ERROR] Could not read shell registry: $_" -ForegroundColor Red
}

# Check processes
$neonShellProcess = Get-Process -Name "NeonShell" -ErrorAction SilentlyContinue
if ($neonShellProcess) {
    Write-Host "[OK] NeonShell is running (PID: $($neonShellProcess.Id))" -ForegroundColor Green
} else {
    Write-Host "[INFO] NeonShell is not running" -ForegroundColor Yellow
}

# Check developer mode
try {
    $devMode = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue
    if ($devMode -and $devMode.AllowDevelopmentWithoutDevLicense -eq 1) {
        Write-Host "[OK] Developer Mode is enabled" -ForegroundColor Green
    } else {
        Write-Host "[WARN] Developer Mode is not enabled" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERROR] Could not check developer mode: $_" -ForegroundColor Red
}

Write-Host "Diagnostics complete." -ForegroundColor Cyan
Pause
