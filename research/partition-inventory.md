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

## Properties cross-check

| Property | Status | Value | Source |
|---|---|---|---|
| ro.boot.dynamic_partitions | Verified | true | getprop-key-lines.txt |
| ro.boot.slot_suffix | Verified | _a | getprop-key-lines.txt |
