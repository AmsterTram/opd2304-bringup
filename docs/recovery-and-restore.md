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
- Confirmed restore procedure: **Unknown**

## Pre-risk checklist

- [ ] Backup personal data off-device
- [ ] Confirm ability to enter bootloader/recovery modes
- [ ] Archive `fastboot getvar all` output
- [ ] Record active build fingerprint and software version

## Warnings

Operations that modify `vbmeta`, `boot`, `vendor_boot`, `init_boot`, `dtbo`, or `super` are **Risky** and may be **Destructive** without a tested restore path.
