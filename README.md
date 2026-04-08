# opd2304-bringup

Evidence-first bring-up workspace for **OnePlus Pad Go (OPD2304)** custom ROM support.

This repository is meant to support **research, extraction, partition mapping, GSI testing, blob handling, recovery planning, and cautious device bring-up** for the OnePlus Pad Go.

It does **not** imply that a working custom ROM already exists for this device.

---

## Purpose

The goal of this repo is to create a solid technical foundation for future AOSP-derived ROM support for the **OnePlus Pad Go OPD2304**, using a conservative and verifiable workflow.

This repo focuses on:

- collecting evidence from stock firmware and hardware
- documenting verified facts vs assumptions
- testing GSI feasibility
- planning proprietary blob extraction
- mapping the boot chain and partitions
- preparing realistic device-support scaffolding
- preserving a safe path back to stock

---

## Current status

**Project stage:** early bring-up / research

### Verified
- **Device:** OnePlus Pad Go
- **Model:** `OPD2304`
- **Observed firmware:** `OPD2304_14.0.0.2900(EX01B40P02)`
- **Observed Android version:** `14`
- **Observed kernel string:** `5.10.236-android12-9-o-g838a99159cea`

### Inferred
- **Likely platform family:** MediaTek Helio G99 / `mt6789`

### Unknown / needs verification
- whether the device uses A/B slots
- whether dynamic partitions are present
- whether `vendor_boot` and `init_boot` are involved in the current boot flow
- exact partition layout
- GSI bootability
- stock firmware package availability for the exact observed build
- completeness and usefulness of publicly available kernel/source releases
- modem/LTE bring-up complexity on this model variant

---

## Project principles

This repo follows a few strict rules:

1. **Evidence first**  
   Verified facts take priority over assumptions.

2. **Read-only first**  
   Data collection and analysis come before unlocking, flashing, or patching.

3. **Recovery first**  
   Any risky workflow must include a documented path back to stock.

4. **No fake support**  
   This repo should never pretend the device is supported when it is not.

5. **Separate fact from inference**  
   Use explicit labels like `Verified`, `Inferred`, `Unknown`, and `Needs verification`.

For repo-specific agent behavior, see [`AGENTS.md`](./AGENTS.md).

---

## Risks and warnings

Android device bring-up work is inherently risky.

### Important
- **Unlocking the bootloader will usually wipe user data**
- flashing the wrong image can soft-brick or hard-brick a device
- vbmeta / AVB changes can prevent boot
- modern Android devices may require handling of `boot`, `vendor_boot`, `init_boot`, `vbmeta`, `dtbo`, `super`, and fastbootd workflows
- do not proceed without a restore path

This repo is designed to reduce guesswork, not eliminate risk.

---

## Near-term objectives

The immediate goals are:

1. collect device evidence from stock
2. map partitions and boot-chain components
3. identify safe stock recovery options
4. acquire and unpack stock OTA/firmware files
5. evaluate whether a GSI test is feasible
6. plan proprietary blob extraction
7. scaffold future bring-up work honestly

---

## Recommended workflow

### Phase 1: stock evidence collection
Collect data from the tablet before attempting any modifications.

Typical safe commands include:

```bash
adb shell getprop > getprop-opd2304.txt
adb shell ls -l /dev/block/by-name > by-name.txt
adb shell cat /proc/partitions > partitions.txt
adb shell cat /proc/cmdline > cmdline.txt
adb shell getprop ro.boot.slot_suffix
adb shell getprop ro.boot.dynamic_partitions
adb shell getprop ro.treble.enabled
