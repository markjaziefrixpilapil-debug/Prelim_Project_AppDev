<#
Run the Flutter project from the project folder.

Usage examples (run from project root in VS Code integrated terminal):
  # auto: run pub get, list devices and run on single available device
  powershell -ExecutionPolicy Bypass -File .\scripts\run_project.ps1

  # run on Chrome (web)
  powershell -ExecutionPolicy Bypass -File .\scripts\run_project.ps1 -Web

  # run on specific device id
  powershell -ExecutionPolicy Bypass -File .\scripts\run_project.ps1 -DeviceId "emulator-5554"

Notes:
- This script requires `flutter` to be on PATH in the terminal session.
- If multiple devices are found and `-DeviceId` is not provided, the script will list devices and exit.
#>

param(
    [string]$ProjectPath = (Get-Location).Path,
    [string]$DeviceId = $null,
    [switch]$Web
)

function Fail($msg) {
    Write-Host $msg -ForegroundColor Red
    exit 1
}

Write-Host "Running Flutter project at: $ProjectPath" -ForegroundColor Cyan

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Fail "flutter not found in PATH. Ensure Flutter is installed and PATH contains the flutter bin folder."
}

Push-Location $ProjectPath
try {
    Write-Host "Running: flutter pub get" -ForegroundColor Green
    flutter pub get
    if ($LASTEXITCODE -ne 0) { Fail "flutter pub get failed (exit $LASTEXITCODE)" }

    Write-Host "Listing devices: flutter devices" -ForegroundColor Green
    # Capture raw output for fallback/debugging
    $devicesRaw = flutter devices --machine | Out-String
    # flutter's --machine output may emit one JSON object per line rather than a single JSON array.
    # Parse line-by-line and aggregate valid JSON objects into an array.
    $devices = @()
    $rawLines = flutter devices --machine 2>&1 | Out-String
    foreach ($line in $rawLines -split "`n") {
        $trim = $line.Trim()
        if ([string]::IsNullOrWhiteSpace($trim)) { continue }
        try {
            $obj = $trim | ConvertFrom-Json -ErrorAction Stop
            if ($obj -ne $null) { $devices += $obj }
        } catch {
            # ignore lines that are not valid JSON
        }
    }
    if ($Web) {
        Write-Host "Running on web (chrome)" -ForegroundColor Green
        flutter run -d chrome
        exit $LASTEXITCODE
    }

    if ($DeviceId) {
        Write-Host "Launching on device id: $DeviceId" -ForegroundColor Green
        flutter run -d $DeviceId
        exit $LASTEXITCODE
    }

    if ($devices.Count -eq 0) {
        # Try parsing the human-readable `flutter devices` output regardless of --machine output
        $plainDevices = @()
        $prettyRaw = flutter devices | Out-String
            foreach ($line in $prettyRaw -split "`n") {
                $l = $line.Trim()
                if (-not $l) { continue }
                # Normalize common separators (Unicode bullets, middle dot, or multiple spaces)
                $norm = $l -replace '•','|' -replace '·','|' -replace '\s{2,}','|'
                $parts = $norm -split '\|'
                if ($parts.Length -ge 3) {
                    $name = $parts[0].Trim()
                    $id = $parts[1].Trim()
                    $platform = $parts[2].Trim()
                    # sanitize id to remove stray non-alphanumeric characters (handling encoding artifacts)
                    $id = ($id -replace '[^A-Za-z0-9_\-]','')
                    if (-not [string]::IsNullOrWhiteSpace($id)) {
                        $plainDevices += [PSCustomObject]@{ id = $id; name = $name; platform = $platform }
                    }
                }
            }
        if ($plainDevices.Count -gt 0) {
            $devices = $plainDevices
        } else {
            # As a last resort, scan the pretty output for known device ids and auto-select
            $prettyRaw = $prettyRaw -join "`n"
            foreach ($p in @('windows','linux','macos')) {
                if ($prettyRaw -match "\b$p\b") {
                    Write-Host "Auto-selecting device id '$p' based on flutter devices output" -ForegroundColor Green
                    flutter run -d $p
                    exit $LASTEXITCODE
                }
            }
            Write-Host 'Could not parse "flutter devices" machine JSON; showing raw output:' -ForegroundColor Yellow
            flutter devices
            Fail "No device selected. Re-run with -DeviceId <id> or start an emulator."
        }
    }

    $count = $devices.Length
    if ($count -eq 0) {
        Write-Host "No connected devices or emulators found." -ForegroundColor Yellow
        Write-Host "Start an emulator (Android Studio AVD) or connect a device, then rerun this script." -ForegroundColor Yellow
        Exit 2
    } elseif ($count -eq 1) {
        $did = $devices[0].id
        Write-Host "Single device found: $did. Launching..." -ForegroundColor Green
        flutter run -d $did
        exit $LASTEXITCODE
    } else {
        Write-Host "Multiple devices found:" -ForegroundColor Yellow
        foreach ($d in $devices) {
            Write-Host "- $($d.id) : $($d.name) ($($d.platform))"
        }

        # Try to auto-select a desktop device if available (prefer desktop over web)
        $preferredOrder = @('windows','linux','macos','chrome','edge')
        $selected = $null
        foreach ($p in $preferredOrder) {
            $selected = $devices | Where-Object { $_.platform -like "*$p*" } | Select-Object -First 1
            if ($selected) { break }
        }

        if ($selected) {
            Write-Host "Auto-selecting preferred device: $($selected.id) ($($selected.name))" -ForegroundColor Green
            flutter run -d $($selected.id)
            exit $LASTEXITCODE
        }

        Fail "Provide -DeviceId <id> to select a device, or use -Web to run on Chrome."
    }
} finally {
    Pop-Location
}
