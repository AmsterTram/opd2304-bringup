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
```

In bootloader / fastboot:

```bash
fastboot getvar all 2>&1 | tee fastboot-vars.txt
```

### Phase 2: firmware and restore path

Before any serious bring-up work:

- identify exact stock build
- obtain full OTA / payload / restore package if possible
- document rollback or stock restore process

### Phase 3: partition and boot-chain mapping

Confirm the role of:

- `boot`
- `vendor_boot`
- `init_boot`
- `vbmeta`
- `dtbo`
- `super`
- fastbootd
- slot behavior, if present

### Phase 4: GSI feasibility

Do not start with a full custom ROM build if a GSI smoke test has not been evaluated first.

### Phase 5: blob and source strategy

Determine:

- what can be derived from public source releases
- what must be extracted from stock firmware or a live device
- which hardware features are likely to need proprietary support

### Phase 6: bring-up scaffolding

Only after evidence is collected should this repo gain:

- device notes
- vendor/blob manifests
- kernel/source references
- carefully marked placeholders for future device tree work

---

## Repository structure

Planned or expected layout:

```text
.
├── AGENTS.md
├── README.md
├── docs/
│   ├── device-profile.md
│   ├── partition-research.md
│   ├── blob-extraction-plan.md
│   ├── gsi-test-plan.md
│   ├── bringup-roadmap.md
│   └── recovery-and-restore.md
├── scripts/
│   ├── collect_*.sh
│   ├── analyze_*.py
│   └── unpack_*.py
├── research/
│   ├── firmware-inventory.md
│   ├── partition-inventory.md
│   ├── proprietary-blob-tracker.md
│   └── hardware-bringup-matrix.md
├── device/
├── vendor/
└── kernel/
```

Not every directory needs to exist immediately. The repo should grow based on evidence, not wishful structure.

---

## What “done” looks like at this stage

A useful first version of this repo should include:

- a clear device fact sheet
- a partition mapping document
- safe read-only collection scripts
- notes on OTA/payload unpacking
- a recovery-first workflow
- a GSI test plan
- a proprietary blob extraction plan
- a realistic bring-up roadmap

A full device tree is **not** expected at the start.

---

## First commands to run

These are good first data-collection steps once USB debugging is enabled:

```bash
adb devices
adb shell getprop | tee getprop-full.txt
adb shell ls -l /dev/block/by-name | tee by-name.txt
adb shell cat /proc/partitions | tee partitions.txt
adb shell cat /proc/cmdline | tee cmdline.txt
adb shell getprop ro.build.fingerprint
adb shell getprop ro.product.device
adb shell getprop ro.boot.slot_suffix
adb shell getprop ro.boot.dynamic_partitions
adb shell getprop ro.treble.enabled
```

Then reboot to bootloader and collect:

```bash
fastboot devices
fastboot getvar all 2>&1 | tee fastboot-vars.txt
```

Store these outputs in a dated folder.

---

## Contribution guidelines

Contributions should be:

- small
- reviewable
- evidence-based
- explicit about uncertainty

Good examples:

- add a safe collection script
- improve device-profile docs
- add verified partition findings
- document restore procedures
- improve OTA unpacking notes

Bad examples:

- adding guessed board config values
- claiming GSI or ROM support without logs
- copying device trees from unrelated devices without explanation

---

## Current blockers

Known likely blockers include:

- lack of verified full firmware package for the exact current build
- incomplete confirmation of partition layout
- unknown GSI compatibility state
- unknown difficulty of LTE-related bring-up
- possible mismatch between public source drops and the current observed firmware

---

## Next step

The best next move is to gather **read-only evidence from the stock tablet** and document it under `docs/` and `research/`.

If you are using Codex, start with a prompt like:

> Inspect this repository and set up the initial OPD2304 bring-up workspace following AGENTS.md. Prioritize safe evidence collection scripts, docs, and research templates. Do not invent unsupported flashing details.

---

## Disclaimer

This project is intended for owners, developers, and researchers working on their own hardware.

Use at your own risk.
