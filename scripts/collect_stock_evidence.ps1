# Safe/read-only data collection helper for OPD2304 bring-up research.
# Reads from connected device via adb/fastboot.
# Writes local text logs into a timestamped output directory.
# Destructive: no.

$ErrorActionPreference = "Stop"

function Require-Command {
    param([Parameter(Mandatory = $true)][string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "ERROR: '$Name' not found in PATH"
    }
}

function Save-CommandOutput {
    param(
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][scriptblock]$Command,
        [Parameter(Mandatory = $true)][string]$OutFile,
        [switch]$Optional
    )

    Write-Host "[+] $Label"

    try {
        & $Command 2>&1 | Tee-Object -FilePath $OutFile | Out-Null
        return $true
    }
    catch {
        $_ | Out-String | Set-Content -Path ($OutFile + ".error.txt")
        if ($Optional) {
            Write-Warning "$Label failed (optional). See $OutFile.error.txt"
            return $false
        }

        throw
    }
}

Require-Command adb
Require-Command fastboot

$ts = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHHmmssZ")
$outDir = Join-Path "research/evidence" $ts
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Write-Host "[+] Output directory: $outDir"

Save-CommandOutput -Label "Checking adb device state" -Command { adb devices } -OutFile (Join-Path $outDir "adb-devices.txt") | Out-Null

Save-CommandOutput -Label "Collecting getprop" -Command { adb shell getprop } -OutFile (Join-Path $outDir "getprop-full.txt") | Out-Null
Save-CommandOutput -Label "Collecting /dev/block/by-name" -Command { adb shell ls -l /dev/block/by-name } -OutFile (Join-Path $outDir "by-name.txt") | Out-Null

# /proc restrictions vary by device build. Keep collection best-effort and explicit.
$partitionsOk = Save-CommandOutput -Label "Collecting /proc/partitions" -Command { adb shell cat /proc/partitions } -OutFile (Join-Path $outDir "proc-partitions.txt") -Optional
$cmdlineOk = Save-CommandOutput -Label "Collecting /proc/cmdline" -Command { adb shell cat /proc/cmdline } -OutFile (Join-Path $outDir "proc-cmdline.txt") -Optional

Save-CommandOutput -Label "Collecting ro.build.fingerprint" -Command { adb shell getprop ro.build.fingerprint } -OutFile (Join-Path $outDir "ro-build-fingerprint.txt") | Out-Null
Save-CommandOutput -Label "Collecting ro.product.device" -Command { adb shell getprop ro.product.device } -OutFile (Join-Path $outDir "ro-product-device.txt") | Out-Null
Save-CommandOutput -Label "Collecting ro.boot.slot_suffix" -Command { adb shell getprop ro.boot.slot_suffix } -OutFile (Join-Path $outDir "ro-boot-slot-suffix.txt") | Out-Null
Save-CommandOutput -Label "Collecting ro.boot.dynamic_partitions" -Command { adb shell getprop ro.boot.dynamic_partitions } -OutFile (Join-Path $outDir "ro-boot-dynamic-partitions.txt") | Out-Null
Save-CommandOutput -Label "Collecting ro.treble.enabled" -Command { adb shell getprop ro.treble.enabled } -OutFile (Join-Path $outDir "ro-treble-enabled.txt") | Out-Null

# Optional fallback attempts for builds with restricted /proc access.
Save-CommandOutput -Label "Fallback: collect /proc/mounts" -Command { adb shell cat /proc/mounts } -OutFile (Join-Path $outDir "proc-mounts.txt") -Optional | Out-Null
Save-CommandOutput -Label "Fallback: list /proc" -Command { adb shell ls -l /proc } -OutFile (Join-Path $outDir "proc-ls-l.txt") -Optional | Out-Null
Save-CommandOutput -Label "Fallback: collect ro.boot.bootdevice" -Command { adb shell getprop ro.boot.bootdevice } -OutFile (Join-Path $outDir "ro-boot-bootdevice.txt") -Optional | Out-Null
Save-CommandOutput -Label "Fallback: collect ro.boot.verifiedbootstate" -Command { adb shell getprop ro.boot.verifiedbootstate } -OutFile (Join-Path $outDir "ro-boot-verifiedbootstate.txt") -Optional | Out-Null

"proc_partitions_readable=$partitionsOk`nproc_cmdline_readable=$cmdlineOk" | Set-Content -Path (Join-Path $outDir "collection-status.txt")

Write-Host "[+] Optional: reboot to bootloader before running fastboot collection."
Write-Host "[+] Attempting fastboot query (will fail harmlessly if not in fastboot mode)."

Save-CommandOutput -Label "Collecting fastboot devices" -Command { fastboot devices } -OutFile (Join-Path $outDir "fastboot-devices.txt") -Optional | Out-Null
Save-CommandOutput -Label "Collecting fastboot getvar all" -Command { cmd /c "fastboot getvar all 2>&1" } -OutFile (Join-Path $outDir "fastboot-getvar-all.txt") -Optional | Out-Null

Write-Host "[+] Done. Next steps:"
Write-Host "    1) Review $outDir outputs"
Write-Host "    2) Update docs/device-profile.md and docs/partition-research.md with Verified findings"
Write-Host "    3) Keep Unknown vs Inferred items explicit"
