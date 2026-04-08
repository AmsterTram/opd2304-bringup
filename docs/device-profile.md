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

## Unknown / Needs verification

- Boot slot scheme (A/B or otherwise)
- Dynamic partitions support
- Full partition inventory from stock
- Presence and role of `vendor_boot` and `init_boot`
- Fastbootd behavior and requirements
- Exact stock restore package sources for observed build

## Evidence targets

Collect and archive:

- `adb shell getprop`
- `/dev/block/by-name` listing
- `/proc/partitions`
- `/proc/cmdline`
- `fastboot getvar all`

Store results under a dated folder, for example `research/evidence/2026-04-08/`.
