# Recovery and restore (OPD2304)

## Objective

Document a restore-first workflow before any risky experimentation.

## Must-have information

- Exact stock build identifier from the device
- Known stock package options for the same build or region
- Bootloader unlock consequences (data wipe expectations)
- Partition list involved in boot

## Current status

- Stock package source for observed build: **Unknown**
- Confirmed full restore procedure: **Unknown**
- Fastboot connectivity: **Verified**
- Fastboot reported unlock state (2026-04-10 evidence): **unlocked: no**
- Build fingerprint captured: **Verified** (`OnePlus/OPD2304EEA/OP5DA6L1:14/UKQ1.230924.001/T.R4T1.22e07d8_2:user/release-keys`)

## Pre-risk checklist

- [ ] Backup personal data off-device
- [ ] Confirm ability to enter bootloader/recovery modes
- [x] Archive key fastboot variables (`product`, `slot-count`, `current-slot`, `unlocked`, `is-userspace`)
- [x] Record active build fingerprint and software version in docs
- [ ] Collect and archive `proc-cmdline.txt`
- [ ] Document stock package acquisition and verified rollback procedure

## Warnings

Operations that modify `vbmeta`, `boot`, `vendor_boot`, `init_boot`, `dtbo`, or `super` are **Risky** and may be **Destructive** without a tested restore path.

If unlock state is `no`, avoid flash workflows until unlock process and consequences are explicitly confirmed and documented.
