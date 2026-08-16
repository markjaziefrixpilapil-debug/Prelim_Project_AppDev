<#
PowerShell helper to install Flutter SDK on Windows.

Usage (run as Administrator to set Machine PATH):
  powershell -ExecutionPolicy Bypass -File .\scripts\install_flutter_windows.ps1 -InstallPath C:\src\flutter -AddToPath -RunDoctor

Notes:
- Requires Git to clone the Flutter repo. If Git is not installed, install Git for Windows first:
  https://git-scm.com/download/win
- If you prefer a ZIP install, extract to the chosen path and run the PATH step manually.
#>

param(
    [string]$InstallPath = 'C:\src\flutter',
    [switch]$AddToPath = $true,
    [switch]$RunDoctor = $true
)

function Test-Admin {
    $current = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $current.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Write-Host "Flutter installer helper"
Write-Host "Install path: $InstallPath"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git is required but not found in PATH. Please install Git for Windows and re-run this script." -ForegroundColor Yellow
    Write-Host "Download: https://git-scm.com/download/win"
    exit 2
}

if (Test-Path $InstallPath) {
    Write-Host "Install path already exists: $InstallPath" -ForegroundColor Cyan
    Write-Host "Skipping clone. To force reinstall, remove the folder and rerun." -ForegroundColor Cyan
} else {
    Write-Host "Cloning Flutter stable branch into $InstallPath..." -ForegroundColor Green
    git clone --depth 1 -b stable https://github.com/flutter/flutter.git $InstallPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "git clone failed (exit $LASTEXITCODE)." -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

$binPath = Join-Path $InstallPath 'bin'

if ($AddToPath) {
    $isAdmin = Test-Admin
    if ($isAdmin) { $scope = 'Machine' } else { $scope = 'User' }
    Write-Host "Adding $binPath to PATH (scope: $scope)" -ForegroundColor Green

    # Read existing PATH and update if needed
    $existing = [Environment]::GetEnvironmentVariable('Path', $scope)
    if ($existing -notlike "*${binPath}*") {
        $new = $existing + ";" + $binPath
        try {
            [Environment]::SetEnvironmentVariable('Path', $new, $scope)
            # Update current process PATH so subsequent flutter calls work immediately
            $env:Path += ";$binPath"
            Write-Host "PATH updated for $scope. You may need to restart terminals to see changes." -ForegroundColor Green
        } catch {
            Write-Host "Failed to update PATH for scope ${scope}: $_" -ForegroundColor Yellow
            Write-Host "If you ran without Administrator rights, rerun as Administrator to set Machine PATH or set CurrentUser PATH manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "PATH already contains $binPath" -ForegroundColor Cyan
    }
}

if ($RunDoctor) {
    Write-Host "Running 'flutter --version' and 'flutter doctor'..." -ForegroundColor Green
    # Ensure flutter executable resolves in this session
    try {
        flutter --version
        flutter doctor
    } catch {
        Write-Host "Running flutter failed. Make sure PATH was updated and restart the terminal if needed." -ForegroundColor Yellow
    }
}

Write-Host "Done. If you see issues, run 'flutter doctor -v' in a new terminal." -ForegroundColor Green
