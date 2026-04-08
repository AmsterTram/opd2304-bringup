# GSI test plan (OPD2304)

## Purpose

Assess whether a minimal GSI smoke test is feasible before full device-tree bring-up work.

## Preconditions

- [ ] Stock evidence archived
- [ ] Partition map partially confirmed
- [ ] Restore path documented in `docs/recovery-and-restore.md`
- [ ] Boot-critical partitions identified with evidence

## Unknowns to resolve first

- AVB/vbmeta handling requirements
- fastbootd requirement for logical partitions
- slot behavior and active slot handling

## Test logging template

| Item | Status | Notes |
|---|---|---|
| GSI image type identified | Unknown | |
| Boot attempt performed | Unknown | |
| Boot log captured | Unknown | |
| Recovery path validated post-test | Unknown | |

## Risk notes

Any operation involving image flashing is **Risky** and potentially **Destructive** if recovery is not ready.
