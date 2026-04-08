# Partition research (OPD2304)

## Status

- Partition map status: **Unknown**
- Slot behavior status: **Needs verification**
- Dynamic partition status: **Needs verification**

## Safe evidence collection checklist

- [ ] `adb shell ls -l /dev/block/by-name`
- [ ] `adb shell cat /proc/partitions`
- [ ] `adb shell getprop ro.boot.slot_suffix`
- [ ] `adb shell getprop ro.boot.dynamic_partitions`
- [ ] `fastboot getvar all`

## Expected output files

- `by-name.txt`
- `partitions.txt`
- `boot-props.txt`
- `fastboot-vars.txt`

## Notes template

### Verified

- _none yet_

### Inferred

- _none yet_

### Unknown

- exact logical partition grouping in `super`
- whether partition names differ across slots

### Needs verification

- role of `init_boot` in this firmware generation
- role of `vendor_boot` in kernel + ramdisk handoff
