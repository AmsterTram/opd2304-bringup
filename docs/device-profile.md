# OPD2304 device profile

## Fact table

| Item | Status | Value | Source |
|---|---|---|---|
| Device name | Verified | OnePlus Pad Go | user-provided |
| Model | Verified | OPD2304 | user-provided |
| Observed firmware | Verified | OPD2304_14.0.0.2900(EX01B40P02) | user-provided |
| Observed Android version | Verified | 14 | user-provided |
| Observed kernel string | Verified | 5.10.236-android12-9-o-g838a99159cea | user-provided |
| ro.product.device | Verified | OP5DA6L1 | research/evidence/2026-04-10T110346Z/getprop-key-lines.txt |
| ro.build.fingerprint | Verified | OnePlus/OPD2304EEA/OP5DA6L1:14/UKQ1.230924.001/T.R4T1.22e07d8_2:user/release-keys | research/evidence/2026-04-10T110346Z/getprop-key-lines.txt |
| ro.treble.enabled | Verified | true | research/evidence/2026-04-10T110346Z/getprop-key-lines.txt |
| ro.boot.dynamic_partitions | Verified | true | research/evidence/2026-04-10T110346Z/getprop-key-lines.txt |
| ro.boot.slot_suffix | Verified | _a | research/evidence/2026-04-10T110346Z/getprop-key-lines.txt |
| ro.boot.verifiedbootstate | Verified | green | research/evidence/2026-04-10T110346Z/fallback-props.txt |
| ro.boot.bootdevice | Verified (empty) | (empty string) | research/evidence/2026-04-10T110346Z/fallback-props.txt |
| fastboot product | Verified | k6789v1_64 | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot slot count | Verified | 2 | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot current slot | Verified | a | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot userspace mode | Verified | no | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| fastboot unlocked state | Verified | no | research/evidence/2026-04-10T110346Z/fastboot-transcript.txt |
| SoC family | Inferred | MediaTek Helio G99 / mt6789 | k6789v1_64 naming + prior inference |

## Unknown / Needs verification

- Full partition inventory normalization (full by-name parse beyond current excerpt)
- Kernel cmdline details (shell user cannot read `/proc/cmdline` on this build)
- Exact stock restore package sources for observed build

## Evidence targets

Collect and archive:

- full `adb shell getprop`
- full `/dev/block/by-name` listing
- `/proc/partitions` (if permitted)
- `/proc/cmdline` (if permitted)
- fallback `/proc/mounts`
- `fastboot getvar all` or targeted `fastboot getvar` values

Store results under dated folders in `research/evidence/`.
