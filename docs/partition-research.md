# Partition research (OPD2304)

## Status

- Partition map status: **Partially verified**
- Slot behavior status: **Verified** (`slot-count: 2`, `current-slot: a`, `ro.boot.slot_suffix: _a`)
- Dynamic partition status: **Verified** (`ro.boot.dynamic_partitions: true`)
- Treble status: **Verified** (`ro.treble.enabled: true`)
- Fastboot mode status: **Verified** (`is-userspace: no`, bootloader fastboot)

## Verified partition evidence (excerpt)

From `research/evidence/2026-04-10T110346Z/by-name-excerpt.txt`:

- `boot_a`, `boot_b`
- `init_boot_a`, `init_boot_b`
- `vendor_boot_a`, `vendor_boot_b`
- `dtbo_a`, `dtbo_b`
- `vbmeta_a`, `vbmeta_b`
- `vbmeta_system_a`, `vbmeta_system_b`
- `vbmeta_vendor_a`, `vbmeta_vendor_b`
- `super`

## Safe evidence collection checklist

- [x] `adb shell ls -l /dev/block/by-name` (excerpt parsed)
- [ ] `adb shell cat /proc/partitions` (not yet parsed)
- [x] `adb shell getprop ro.boot.slot_suffix`
- [x] `adb shell getprop ro.boot.dynamic_partitions`
- [x] `adb shell getprop ro.treble.enabled`
- [x] `fastboot getvar current-slot`
- [x] `fastboot getvar slot-count`
- [x] `fastboot getvar is-userspace`

## Unknown

- complete logical partition grouping inside `super`
- whether other critical partition aliases exist outside current excerpt

## Needs verification

- kernel boot cmdline (`proc-cmdline.txt` missing)
- restore path details aligned to this exact fingerprint/build
