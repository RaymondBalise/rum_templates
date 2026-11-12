---
name: rum-devlog
description: >-
  Audit R and Quarto/RMarkdown code comments, log analytical or architectural
  decisions in DECISIONS.md, and update CHANGELOG.md (projects) or NEWS.md
  (R packages) before committing or completing a milestone.
---

# `{rUM}` Developer Log & Documentation Gate (`rum-devlog`)

Audit modified R and manuscript files for high-signal comments, record key
decisions in `DECISIONS.md`, and maintain `CHANGELOG.md` (for analysis
projects) or `NEWS.md` (when `DESCRIPTION` is present at the package root).

When invoked without arguments, run Steps 0 through 4 in order. If the user
requests only `comments`, `decisions`, or `changelog`, run Step 0 followed by
that step.

---

## Step 0: Reconnaissance & Mode Detection

1. Run `git status -s` and `git diff` (or `git show HEAD` if clean) to list
   modified `.R`, `.qmd`, `.Rmd`, and `.scss` files.
2. **Detect Project vs. Package Mode**:
   * **Package Mode** (`DESCRIPTION` exists at root): Use **`NEWS.md`** for
     changelog entries and read `Package:` from `DESCRIPTION`. Ensure
     `^DECISIONS\.md$` is present in `.Rbuildignore` if `DECISIONS.md` is
     created.
   * **Project Mode** (no `DESCRIPTION` at root): Use **`CHANGELOG.md`**.

---

## Step 1: Code Commenting Audit (`comments`)

Audit modified `.R`, `.qmd`, and `.Rmd` files against these rules:

1. **Explain the "Why", Never the "What"**:
   * Omit comments that restate syntax (`# filter body_mass_g > 3000`).
   * Document non-obvious domain rules, exclusion criteria, modeling choices,
     or magic numbers directly above the block:
     ```r
     # Drop observations missing bill measurements prior to PCA scaling so row
     # indices align across model comparison folds.
     penguins_complete <- penguins |>
       tidyr::drop_na(bill_length_mm, bill_depth_mm)
     ```
2. **Traceability on Threshold / Covariate Changes**:
   * Preserve prior cutoffs, covariates, or filenames with a dated comment
     explaining why the value changed.
3. **Formatting**:
   * Wrap all comment and `roxygen2` lines at or before **80 characters**.

---

## Step 2: Decision Record (`decisions` -> `DECISIONS.md`)

Log substantive analytical, statistical, or architectural choices in
`DECISIONS.md` at the project root (skip typos, formatting, or trivial fixes):

1. **Scaffold `DECISIONS.md` (If Missing)**:
   ```markdown
   # Project Decision Log

   Analytical, statistical, and technical decisions recorded chronologically
   (newest entries first).

   ---

   ## YYYY-MM-DD: <Short Decision Title>

   - **Context**: What data issue, analytical question, or constraint arose?
   - **Decision**: What method, filter, model, or architecture was chosen?
   - **Rationale & Trade-offs**: Why this option, and what are its limits?
   - **Related Files**: `analysis.qmd`, `R/clean_data.R`
   ```
   *(In Package Mode, also append `^DECISIONS\.md$` to `.Rbuildignore` if not
   already listed.)*
2. **Update Entries**:
   If an entry for the current date (`## YYYY-MM-DD: ...`) already exists,
   append to it rather than creating a duplicate date entry; otherwise prepend
   a new dated entry directly below `---` (`<= 80` chars per line).

---

## Step 3: Changelog (`changelog` -> `CHANGELOG.md` or `NEWS.md`)

* **Project Mode (`CHANGELOG.md`, Keep a Changelog)**:
  Scaffold if missing, then add concise bullets under `## [Unreleased]`
  (`### Added`, `### Changed`, `### Fixed`, or `### Removed`):
  ```markdown
  # Changelog

  All notable changes to this project are documented in this file.

  ## [Unreleased]

  ### Added
  - Initial `{rUM}` analysis structure and baseline summary tables.
  ```
* **Package Mode (`NEWS.md`, CRAN / `pkgdown` format)**:
  Read `<pkg>` from `DESCRIPTION` (`Package:` field). Scaffold `NEWS.md` if
  missing, then add top-level bullets under `# <pkg> (development version)`:
  ```markdown
  # <pkg> (development version)

  * Added baseline vignette analysis and helper functions.
  ```

---

## Step 4: Summary

Report a brief summary of:
* **Code Comments**: Files audited and "why" comments added or tightened.
* **Decisions**: `DECISIONS.md` entry added (or skipped as routine).
* **Changelog**: `CHANGELOG.md` or `NEWS.md` bullets updated.
