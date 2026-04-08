# AGENTS.md

## Purpose

This repository is a cautious bring-up workspace for **OnePlus Pad Go (OPD2304)** custom ROM support.

The goal is to build a **real, evidence-based path** toward device support for AOSP-derived ROMs.
This repo is for research, extraction, mapping, scaffolding, testing, and documentation.

This repo is **not** proof that the device already has working custom ROM support.

---

## Device scope

Current target:

- **Device**: OnePlus Pad Go
- **Model**: OPD2304
- **Observed firmware**: `OPD2304_14.0.0.2900(EX01B40P02)`
- **Observed Android version**: 14
- **Observed kernel string**: `5.10.236-android12-9-o-g838a99159cea`
- **Likely platform family**: MediaTek Helio G99 / mt6789

Treat any item above as needing reconfirmation if newer evidence appears.

---

## Core principles

1. **Evidence first**
   - Prefer collected facts over assumptions.
   - Do not invent partition names, flashing steps, image names, or board configuration values.

2. **Read-only first**
   - Any new device-interaction script must default to safe evidence collection.
   - Flashing, formatting, unlocking, vbmeta changes, and boot image patching must never be the default path.

3. **Do not fake support**
   - Do not scaffold files that imply a complete, working device tree unless there is evidence to support them.
   - Placeholders are acceptable only when clearly marked as placeholders.

4. **Separate fact from inference**
   - In docs, use labels such as:
     - **Verified**
     - **Inferred**
     - **Unknown**
     - **Needs verification**

5. **Optimize for recoverability**
   - Always prefer workflows that preserve a path back to stock.
   - Recovery and restore documentation is mandatory alongside risky workflows.

6. **Small, reviewable changes**
   - Make incremental edits.
   - Update docs whenever a script, assumption, or workflow changes.

---

## Project goals

Work should generally support these phases:

1. Evidence collection from stock device
2. Stock firmware / OTA acquisition and unpacking
3. Partition and boot-chain mapping
4. GSI feasibility testing
5. Proprietary blob extraction
6. Device tree and vendor tree scaffolding
7. Kernel/source reconciliation
8. Early boot experiments
9. Hardware bring-up and stabilization

---

## What agents should do

When working in this repo, agents should:

- Inspect the existing repo before creating new files
- Preserve useful structure and improve it rather than replacing it blindly
- Prefer practical documentation, scripts, and checklists over generic prose
- Keep commands concise and copy-pasteable
- Add warnings for destructive steps
- Keep all risky operations clearly separated from safe ones
- Update status docs when new evidence is introduced

Agents should aim to leave the repo in a state that is immediately useful to a technically capable Android modder.

---

## What agents must not do

Agents must **not**:

- Claim that a ROM boots unless there is explicit verification
- Invent a working `BoardConfig.mk`, recovery config, or vendor manifest
- Invent OTA download links
- Invent partition layouts
- Assume A/B, dynamic partitions, `vendor_boot`, or `init_boot` without evidence
- Add “flash-all” style scripts by default
- Hide risk behind vague wording
- Collapse verified and speculative information into one list

---

## File and folder expectations

Typical structure may include:

- `README.md`
- `docs/`
- `scripts/`
- `research/`
- `device/`
- `vendor/`
- `kernel/`

### Documentation
Docs should stay concise, technical, and explicit about uncertainty.

Recommended docs:

- `docs/device-profile.md`
- `docs/partition-research.md`
- `docs/blob-extraction-plan.md`
- `docs/gsi-test-plan.md`
- `docs/bringup-roadmap.md`
- `docs/recovery-and-restore.md`

### Scripts
Scripts should be grouped roughly as:

- safe read-only collection scripts
- local firmware/OTA unpack helpers
- data organization helpers

Any script that touches a connected device should state clearly:
- what it reads
- what it writes
- whether it is destructive
- prerequisites

---

## Documentation style rules

Use short sections and technical language.

For device facts, prefer tables like:

| Item | Status | Value | Source |
|---|---|---|---|
| Model | Verified | OPD2304 | user-provided |
| Android version | Verified | 14 | user-provided |
| SoC | Inferred | mt6789 / Helio G99 | needs verification |

When documenting commands:
- separate safe commands from risky commands
- mark destructive commands explicitly
- explain expected outputs where helpful

Use these markers consistently:

- `Verified`
- `Inferred`
- `Unknown`
- `Needs verification`
- `Risky`
- `Destructive`

---

## Coding and scripting rules

### General
- Prefer Python or shell for tooling unless another language is clearly better
- Keep scripts simple and dependency-light
- Use timestamped output directories for logs and dumps
- Fail loudly on missing prerequisites
- Print clear next steps after completion

### Safe-by-default behavior
Device scripts must default to read-only actions such as:
- `adb shell getprop`
- `adb shell ls -l /dev/block/by-name`
- `fastboot getvar all`
- local unpacking of user-supplied firmware files

Do not make unlocking or flashing the default.

### Script naming
Use names that reflect risk level:

- `collect_*` for read-only collection
- `analyze_*` for offline parsing
- `unpack_*` for local firmware processing
- `flash_*` only for explicitly risky/manual workflows

If a script is destructive, say so at the top of the file and in the README.

---

## Bring-up scaffolding rules

If adding bring-up scaffolding:

- Clearly mark placeholders
- Prefer notes/templates over fake completeness
- Do not add a fully populated device tree unless supported by evidence
- Keep speculative values quarantined in notes, not in files that look production-ready

Good:
- `device/oneplus/opd2304/NOTES.md`
- `research/proprietary-files.template.txt`

Bad:
- a pretend-complete `BoardConfig.mk` with guessed values
- a fake `proprietary-files.txt` copied from another device without explanation

---

## Recovery and restore requirements

Before adding risky workflows, ensure the repo documents:

- how to identify the exact firmware build
- what stock packages are available
- how to return to stock
- what partitions are involved in boot
- what unlocking changes
- whether data wipe is expected

Any flashing guide without restore guidance is incomplete.

---

## Commit and change expectations

Prefer small, meaningful commits.

Good examples:
- `docs: add initial OPD2304 device profile`
- `scripts: add safe adb collection helper`
- `research: add partition inventory template`

Avoid giant mixed commits.

---

## Decision rules under uncertainty

If uncertain:

1. Document the uncertainty
2. Add a checklist for verification
3. Prefer a template over a guessed implementation
4. Leave breadcrumbs for the next human or agent

When multiple approaches are possible, prefer:
- reversible
- observable
- low-assumption
- easy to audit

---

## Expected near-term outputs

The most useful near-term outputs are:

- a clean README
- device fact sheet
- partition mapping checklist
- safe data collection scripts
- OTA/payload unpack notes or helpers
- GSI feasibility plan
- blob extraction plan
- recovery-first workflow

These are more valuable than pretending the device tree is already solved.

---

## Human handoff expectations

At the end of substantial work, agents should summarize:

- what was created or changed
- what is verified
- what remains unknown
- what the next exact commands are for the human to run

Whenever possible, those next commands should be safe, read-only evidence gathering steps first.

---

## Repository tone

Be honest, technical, and conservative.

This is a bring-up lab, not a marketing page.
