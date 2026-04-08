#!/usr/bin/env bash
set -euo pipefail

# Safe/read-only data collection helper for OPD2304 bring-up research.
# Reads from connected device via adb/fastboot.
# Writes local text logs into a timestamped output directory.
# Destructive: no.

if ! command -v adb >/dev/null 2>&1; then
  echo "ERROR: adb not found in PATH" >&2
  exit 1
fi

if ! command -v fastboot >/dev/null 2>&1; then
  echo "ERROR: fastboot not found in PATH" >&2
  exit 1
fi

ts="$(date -u +%Y-%m-%dT%H%M%SZ)"
out_dir="research/evidence/${ts}"
mkdir -p "${out_dir}"

echo "[+] Output directory: ${out_dir}"

echo "[+] Checking adb device state..."
adb devices | tee "${out_dir}/adb-devices.txt"

echo "[+] Collecting Android properties and partition context (read-only)..."
adb shell getprop | tee "${out_dir}/getprop-full.txt"
adb shell ls -l /dev/block/by-name | tee "${out_dir}/by-name.txt"
adb shell cat /proc/partitions | tee "${out_dir}/proc-partitions.txt"
adb shell cat /proc/cmdline | tee "${out_dir}/proc-cmdline.txt"
adb shell getprop ro.build.fingerprint | tee "${out_dir}/ro-build-fingerprint.txt"
adb shell getprop ro.product.device | tee "${out_dir}/ro-product-device.txt"
adb shell getprop ro.boot.slot_suffix | tee "${out_dir}/ro-boot-slot-suffix.txt"
adb shell getprop ro.boot.dynamic_partitions | tee "${out_dir}/ro-boot-dynamic-partitions.txt"
adb shell getprop ro.treble.enabled | tee "${out_dir}/ro-treble-enabled.txt"

echo "[+] Optional: reboot to bootloader before running fastboot collection."
echo "[+] Attempting fastboot query (will fail harmlessly if not in fastboot mode)."
(fastboot devices | tee "${out_dir}/fastboot-devices.txt") || true
(fastboot getvar all 2>&1 | tee "${out_dir}/fastboot-getvar-all.txt") || true

echo "[+] Done. Next steps:"
echo "    1) Review ${out_dir} outputs"
echo "    2) Update docs/device-profile.md and docs/partition-research.md with Verified findings"
echo "    3) Keep Unknown vs Inferred items explicit"
