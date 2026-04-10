# Partition research (OPD2304)

## Status

- Partition map status: **Needs verification**
- Slot behavior status: **Verified** (`slot-count: 2`, `current-slot: a`)
- Dynamic partition status: **Needs verification**
- Fastboot mode status: **Verified** (`is-userspace: no`, bootloader fastboot)

## Safe evidence collection checklist

- [ ] `adb shell ls -l /dev/block/by-name` (uploaded, needs transcription)
- [ ] `adb shell cat /proc/partitions` (pending capture/transcription)
- [x] `adb shell getprop ro.boot.slot_suffix` (uploaded, needs value extraction)
- [ ] `adb shell getprop ro.boot.dynamic_partitions` (uploaded, needs value extraction)
- [x] `fastboot getvar current-slot`
- [x] `fastboot getvar slot-count`
- [x] `fastboot getvar is-userspace`

## Verified findings

- `slot-count: 2` (A/B behavior present)
- `current-slot: a`
- `is-userspace: no` (standard bootloader fastboot, not fastbootd)

## Unknown

- exact logical partition grouping in `super`
- whether partition names differ across slots in `/dev/block/by-name`

## Needs verification

- role of `init_boot` in this firmware generation
- role of `vendor_boot` in kernel + ramdisk handoff
- whether dynamic partitions are reported as enabled
