---
name: rum-workflow
description: >-
  Add Quarto documents, modular R scripts, gtsummary tables, slide decks,
  custom SCSS themes, and citation styles following rUM project conventions.
  Activate when adding or organizing files, scripts, tables, slides, or Quarto
  and R Markdown documents in this project.
---

# `{rUM}` Analysis Project Workflow Skill

Maintain `{rUM}` project conventions whenever adding documents, modular R
scripts, presentations, styling, or bibliography rules.

---

## 1. Adding Quarto Documents (`rUM::write_quarto()`)

1. **Scaffold with `{rUM}`**:
   Run in R from the project root:
   ```r
   # Lean starter document (no bibliography boilerplate)
   rUM::write_quarto(filename = "eda_notes")

   # Manuscript template with bibliography + .csl support
   rUM::write_quarto(filename = "manuscript", example = FALSE)
   ```
2. **Chunk & Cross-Reference Conventions**:
   * Match whatever chunk-option style already exists in the `.qmd` file
     (`{r label}` headers with `#| tbl-cap:` / `#| fig-cap:` in the body, or
     pure `#| label:` hashpipes) without rewriting existing headers.
   * Only when creating a blank `.qmd` from scratch or when asked about chunk
     formatting, note the 1-line trade-off (`#| label:` is the Quarto YAML
     standard; `{r label}` keeps chunk names visible when collapsed in
     RStudio/Positron) and follow the user's preference.
   * Prefix table chunk labels with `tbl-` (`@tbl-penguins`) and figure chunk
     labels with `fig-` (`@fig-bill-mass`) so Quarto cross-references resolve.

---

## 2. Modularizing R Scripts (`R/`) & Data Paths

1. **Extract Heavy Wrangling to `R/`**:
   * Keep `analysis.qmd` / `analysis.Rmd` focused on narrative, tables, and
     plots. Move multi-step data cleaning, cohort derivation, and model fitting
     into `R/<script>.R` (e.g., `R/clean_data.R`, `R/fit_models.R`).
   * Source modular scripts near the top of the manuscript using `here::here()`:
     ```r
     source(here::here("R", "clean_data.R"))
     ```
2. **Data Loading & Privacy (`data/`)**:
   * Always construct paths via `here::here("data", "<file>")` (for example,
     `rio::import(here::here("data", "processed.rds"))`).
   * Ask for explicit user confirmation before reading raw datasets in `data/`,
     and never remove data extensions from `.gitignore`.

---

## 3. Citations & `.csl` Style Switching

All three `{rUM}` citation styles ship in `bib/`:
* `bib/apa.csl`: APA 7th edition (default)
* `bib/mla.csl`: MLA 9th edition
* `bib/the-new-england-journal-of-medicine.csl`: NEJM numbered style

To switch styles, update `csl:` in the document YAML header:
```yaml
bibliography: [bib/references.bib, bib/packages.bib]
csl: bib/the-new-england-journal-of-medicine.csl
```

---

## 4. Custom Styling (`custom.scss`) & Slide Decks (`slides/`)

1. **Quarto HTML Styling (`rUM::write_scss()`)**:
   * Edit `custom.scss` using Quarto's three section markers
     (`/*-- scss:defaults --*/`, `/*-- scss:mixins --*/`,
     `/*-- scss:rules --*/`), or generate an additional stylesheet:
     ```r
     rUM::write_scss(filename = "tables", add_to_yaml = TRUE)
     ```
2. **Revealjs Slide Decks (`rUM::write_slides()`)**:
   * Scaffold a presentation in `slides/` (`template = "none"`, `"miami"`, or
     `"rmed"`):
     ```r
     rUM::write_slides(filenames = "kickoff", template = "none")
     ```

---

## 5. Rendering & Verification

1. Verify all `source()` and `rio::import()` / `readr` calls use `here::here()`.
2. Render Quarto documents from the project root (falling back to Positron or
   RStudio bundled Quarto if `quarto` is not on `PATH`):
   ```bash
   QUARTO_BIN="$(command -v quarto \
     || ls /Applications/Positron.app/Contents/Resources/app/quarto/bin/quarto \
           /Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto \
           2>/dev/null | head -n 1)"
   "$QUARTO_BIN" render analysis.qmd
   ```
   For R Markdown documents, run:
   ```bash
   Rscript -e 'rmarkdown::render("analysis.Rmd")'
   ```
3. **Never run `grep`, `sed`, or `read_file` on rendered `.html` outputs**:
   `embed-resources: true` inlines base64 fonts and images onto single
   multi-megabyte lines. Check `quarto render` / `rmarkdown::render()` console
   stderr for R chunk errors (`error: true` in starter templates can return exit
   code `0` even when an R chunk errors).
