# Blob extraction plan (OPD2304)

## Goal

Create a transparent and auditable path to identify and track proprietary components required for bring-up.

## Current status

- Blob manifest: **Unknown**
- Extraction source priority: **Needs verification**

## Candidate sources (safe first)

1. Local extraction from user-supplied OTA payload files
2. Local extraction from full firmware packages
3. Read-only inspection on live stock device

## Non-goals (for now)

- No assumed complete `proprietary-files.txt`
- No copied manifests from unrelated devices without provenance

## Tracker workflow

1. Add discovered blobs to `research/proprietary-blob-tracker.md`
2. Record origin, partition/path, and evidence notes
3. Mark each row as `Verified`, `Inferred`, or `Needs verification`
