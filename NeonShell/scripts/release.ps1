# NeonShell Release Script

Write-Host "Building and packaging NeonShell..." -ForegroundColor Cyan

# Create output directory
$OutputDir = "dist"
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# Build solution
Write-Host "Building solution..." -ForegroundColor Yellow
dotnet build src/NeonShell.sln --configuration Release

# Publish application
Write-Host "Publishing application..." -ForegroundColor Yellow
dotnet publish src/NeonShell/NeonShell.csproj --configuration Release --runtime win-x64 --output $OutputDir/NeonShell --self-contained true

# Copy test app
Write-Host "Copying test application..." -ForegroundColor Yellow
dotnet publish src/TestApp/TestApp.csproj --configuration Release --runtime win-x64 --output $OutputDir/TestApp --self-contained true

# Copy scripts
Write-Host "Copying scripts..." -ForegroundColor Yellow
Copy-Item scripts/*.ps1 $OutputDir/

# Create zip package
Write-Host "Creating zip package..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$zipName = "NeonShell-$timestamp.zip"
Compress-Archive -Path $OutputDir/* -DestinationPath $zipName -Force

Write-Host "Release package created: $zipName" -ForegroundColor Green
Write-Host "Contents:" -ForegroundColor Yellow
Get-ChildItem $OutputDir -Recurse | ForEach-Object {
    Write-Host "  $($_.FullName.Replace($OutputDir, ''))"
}

Pause
