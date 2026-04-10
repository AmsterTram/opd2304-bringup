# Partition research (OPD2304)

## Status

- Partition map status: **Partially verified**
- Slot behavior status: **Verified** (`slot-count: 2`, `current-slot: a`, `ro.boot.slot_suffix: _a`)
- Dynamic partition status: **Verified** (`ro.boot.dynamic_partitions: true`)
- Treble status: **Verified** (`ro.treble.enabled: true`)
- Fastboot mode status: **Verified** (`is-userspace: no`, bootloader fastboot)
- AVB state signal: **Verified** (`ro.boot.verifiedbootstate: green`)

## Verified partition evidence

From `research/evidence/2026-04-10T110346Z/by-name-excerpt.txt`:

- `boot_a`, `boot_b`
- `init_boot_a`, `init_boot_b`
- `vendor_boot_a`, `vendor_boot_b`
- `dtbo_a`, `dtbo_b`
- `vbmeta_a`, `vbmeta_b`
- `vbmeta_system_a`, `vbmeta_system_b`
- `vbmeta_vendor_a`, `vbmeta_vendor_b`
- `super`

From `research/evidence/2026-04-10T110346Z/proc-mounts-excerpt.txt`:

- root `/` mounted from `dm-28` as `erofs`
- `/vendor`, `/product`, `/system_ext`, `/odm` mounted from device-mapper as `erofs`
- `/vendor_dlkm` and `/odm_dlkm` mounted read-only
- `/metadata` on ext4
- `/data` on f2fs

## Safe evidence collection checklist

- [x] `adb shell ls -l /dev/block/by-name` (excerpt parsed)
- [ ] `adb shell cat /proc/partitions` (permission denied as shell user)
- [ ] `adb shell cat /proc/cmdline` (permission denied as shell user)
- [x] `adb shell cat /proc/mounts` (fallback succeeded)
- [x] `adb shell getprop ro.boot.slot_suffix`
- [x] `adb shell getprop ro.boot.dynamic_partitions`
- [x] `adb shell getprop ro.treble.enabled`
- [x] `adb shell getprop ro.boot.verifiedbootstate`
- [x] `fastboot getvar current-slot`
- [x] `fastboot getvar slot-count`
- [x] `fastboot getvar is-userspace`

## Unknown

- complete logical partition grouping inside `super`
- whether other critical partition aliases exist outside current excerpt

## Needs verification

- privileged kernel cmdline read (`/proc/cmdline`) from root/recovery context
- restore path details aligned to this exact fingerprint/build
