# Partition inventory

Populate with direct evidence from stock device output files.

## Fastboot-level verified metadata

| Item | Status | Value | Source |
|---|---|---|---|
| Slot count | Verified | 2 | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| Current slot | Verified | a | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| Fastboot userspace | Verified | no | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |

## By-name verified partition presence (excerpt)

| Partition family | Status | Evidence | Notes |
|---|---|---|---|
| boot_a / boot_b | Verified | by-name-excerpt.txt | A/B boot partitions present |
| init_boot_a / init_boot_b | Verified | by-name-excerpt.txt | A/B init_boot present |
| vendor_boot_a / vendor_boot_b | Verified | by-name-excerpt.txt | A/B vendor_boot present |
| dtbo_a / dtbo_b | Verified | by-name-excerpt.txt | A/B dtbo present |
| vbmeta_a / vbmeta_b | Verified | by-name-excerpt.txt | A/B vbmeta present |
| vbmeta_system_a / vbmeta_system_b | Verified | by-name-excerpt.txt | A/B vbmeta_system present |
| vbmeta_vendor_a / vbmeta_vendor_b | Verified | by-name-excerpt.txt | A/B vbmeta_vendor present |
| super | Verified | by-name-excerpt.txt | dynamic super block present |

## Mount-derived indicators (fallback path)

| Mount | Status | Backing | FS | Source |
|---|---|---|---|---|
| / | Verified | dm-28 | erofs | proc-mounts-excerpt.txt |
| /vendor | Verified | dm-29 | erofs | proc-mounts-excerpt.txt |
| /product | Verified | dm-30 | erofs | proc-mounts-excerpt.txt |
| /system_ext | Verified | dm-31 | erofs | proc-mounts-excerpt.txt |
| /odm | Verified | dm-5 | erofs | proc-mounts-excerpt.txt |
| /vendor_dlkm | Verified | dm-32 | ext4 (ro) | proc-mounts-excerpt.txt |
| /odm_dlkm | Verified | dm-33 | ext4 (ro) | proc-mounts-excerpt.txt |
| /metadata | Verified | /dev/block/by-name/metadata | ext4 | proc-mounts-excerpt.txt |
| /data | Verified | dm-70 | f2fs | proc-mounts-excerpt.txt |

## Properties cross-check

| Property | Status | Value | Source |
|---|---|---|---|
| ro.boot.dynamic_partitions | Verified | true | getprop-key-lines.txt |
| ro.boot.slot_suffix | Verified | _a | getprop-key-lines.txt |
| ro.boot.verifiedbootstate | Verified | green | fallback-props.txt |
| ro.boot.bootdevice | Verified (empty) | (empty string) | fallback-props.txt |
