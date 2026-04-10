# Safe/read-only data collection helper for OPD2304 bring-up research.
# Reads from connected device via adb/fastboot.
# Writes local text logs into a timestamped output directory.
# Destructive: no.

$ErrorActionPreference = "Stop"

function Require-Command($name) {
    if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
        throw "ERROR: '$name' not found in PATH"
    }
}

Require-Command adb
Require-Command fastboot

$ts = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHHmmssZ")
$outDir = Join-Path "research/evidence" $ts
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Write-Host "[+] Output directory: $outDir"

Write-Host "[+] Checking adb device state..."
adb devices | Tee-Object -FilePath (Join-Path $outDir "adb-devices.txt")

Write-Host "[+] Collecting Android properties and partition context (read-only)..."
adb shell getprop | Tee-Object -FilePath (Join-Path $outDir "getprop-full.txt")
adb shell ls -l /dev/block/by-name | Tee-Object -FilePath (Join-Path $outDir "by-name.txt")
adb shell cat /proc/partitions | Tee-Object -FilePath (Join-Path $outDir "proc-partitions.txt")
adb shell cat /proc/cmdline | Tee-Object -FilePath (Join-Path $outDir "proc-cmdline.txt")
adb shell getprop ro.build.fingerprint | Tee-Object -FilePath (Join-Path $outDir "ro-build-fingerprint.txt")
adb shell getprop ro.product.device | Tee-Object -FilePath (Join-Path $outDir "ro-product-device.txt")
adb shell getprop ro.boot.slot_suffix | Tee-Object -FilePath (Join-Path $outDir "ro-boot-slot-suffix.txt")
adb shell getprop ro.boot.dynamic_partitions | Tee-Object -FilePath (Join-Path $outDir "ro-boot-dynamic-partitions.txt")
adb shell getprop ro.treble.enabled | Tee-Object -FilePath (Join-Path $outDir "ro-treble-enabled.txt")

Write-Host "[+] Optional: reboot to bootloader before running fastboot collection."
Write-Host "[+] Attempting fastboot query (will fail harmlessly if not in fastboot mode)."

try {
    fastboot devices | Tee-Object -FilePath (Join-Path $outDir "fastboot-devices.txt")
} catch {
    Write-Warning "fastboot devices failed (likely not in bootloader mode)."
}

try {
    fastboot getvar all 2>&1 | Tee-Object -FilePath (Join-Path $outDir "fastboot-getvar-all.txt")
} catch {
    Write-Warning "fastboot getvar all failed (likely not in bootloader mode)."
}

Write-Host "[+] Done. Next steps:"
Write-Host "    1) Review $outDir outputs"
Write-Host "    2) Update docs/device-profile.md and docs/partition-research.md with Verified findings"
Write-Host "    3) Keep Unknown vs Inferred items explicit"
