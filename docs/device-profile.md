# OPD2304 device profile

## Fact table

| Item | Status | Value | Source |
|---|---|---|---|
| Device name | Verified | OnePlus Pad Go | user-provided |
| Model | Verified | OPD2304 | user-provided |
| Observed firmware | Verified | OPD2304_14.0.0.2900(EX01B40P02) | user-provided |
| Observed Android version | Verified | 14 | user-provided |
| Observed kernel string | Verified | 5.10.236-android12-9-o-g838a99159cea | user-provided |
| SoC family | Inferred | MediaTek Helio G99 / mt6789 | needs verification |
| fastboot product | Verified | k6789v1_64 | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot slot count | Verified | 2 | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot current slot | Verified | a | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot userspace mode | Verified | no | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot unlocked state | Verified | no | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |

## Unknown / Needs verification

- Dynamic partitions support (confirm from collected `ro.boot.dynamic_partitions` content)
- Full partition inventory from stock (`/dev/block/by-name` mapping not yet transcribed)
- Presence and role of `vendor_boot` and `init_boot` in actual boot chain
- Fastbootd behavior and requirements during partition operations
- Exact stock restore package sources for observed build

## Evidence targets

Collect and archive:

- `adb shell getprop`
- `/dev/block/by-name` listing
- `/proc/partitions`
- `/proc/cmdline`
- `fastboot getvar all` or targeted `fastboot getvar` values

Store results under dated folders in `research/evidence/`.
