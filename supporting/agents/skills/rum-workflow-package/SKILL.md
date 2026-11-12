---
name: rum-workflow
description: >-
  Add R package functions, roxygen2 documentation, dataset man pages, vignette
  manuscripts, slide decks, and citation styles following rUM package
  conventions. Activate when adding or modifying R functions, datasets,
  vignettes, slides, or running R CMD check in this package.
---

# `{rUM}` Package Workflow Skill

Maintain CRAN-clean R package structure (`R/`, `man/`, `vignettes/`, `tests/`,
`DESCRIPTION`, `.Rbuildignore`) whenever extending this `{rUM}` package.

---

## 1. Adding Package Functions & Dependencies (`R/` & `DESCRIPTION`)

1. **Function Files (`R/<name>.R`)**:
   * Place exported functions and internal `.helpers()` in `R/<name>.R`.
   * Never use `library()`, `require()`, `source()`, or `setwd()` inside `R/`.
   * Qualify external calls with `pkg::fn()` or `@importFrom pkg fn`, and wrap
     all code, comments, and `roxygen2` tags at `<= 80` characters.
2. **Register Dependencies (`DESCRIPTION`)**:
   ```r
   usethis::use_package("dplyr")               # runtime Imports
   usethis::use_package("gtsummary", "Suggests") # vignette/test Suggests
   ```
3. **Document Datasets (`rUM::write_man()`)**:
   When bundling a clean, non-sensitive dataset in `data/`, save it first with
   `usethis::use_data()` and scaffold its `roxygen2` manual template in `R/`:
   ```r
   usethis::use_data(penguins_summary, overwrite = TRUE)
   rUM::write_man("penguins_summary")
   devtools::document()
   ```

---

## 2. Vignette Manuscripts & Citation Styles (`vignettes/`)

1. **Vignette Location**:
   * Manuscript files (`vignettes/analysis.qmd` or `vignettes/analysis.Rmd`)
     live in `vignettes/` with bibliography and `.csl` files inside
     `vignettes/bib/`.
   * Match the chunk-option style already present in `.qmd` vignettes
     (`{r label}` headers vs `#| label:` hashpipes; `tbl-` and `fig-` prefixes
     for Quarto cross-references). Only mention the 1-line `#| label:` vs
     collapsed-chunk `{r label}` trade-off on blank `.qmd` files or when asked.
2. **Switching Bundled `.csl` Styles**:
   All three styles ship in `vignettes/bib/`:
   * `bib/apa.csl`: APA 7th edition (default)
   * `bib/mla.csl`: MLA 9th edition
   * `bib/the-new-england-journal-of-medicine.csl`: NEJM numbered style

   Update `csl:` in `vignettes/analysis.qmd` (or `.Rmd`) YAML frontmatter to
   switch styles.

---

## 3. Package Slide Decks (`inst/`)

When adding Revealjs slide decks inside an R package, always target `inst/` so
package builds remain valid:
```r
rUM::write_slides(filenames = "overview", path = "inst", template = "none")
```

---

## 4. `.Rbuildignore` & Data Privacy

1. **Top-Level Non-Package Files**:
   Ensure non-standard root files (`^AGENTS\.md$`, `^CLAUDE\.md$`,
   `^GEMINI\.md$`, `^\.agents$`, `^DECISIONS\.md$`) remain in `.Rbuildignore`
   so `R CMD check` emits zero top-level file NOTEs. Note that root `NEWS.md`
   is standard CRAN metadata and must **not** be ignored.
2. **PHI & Raw Data Gate**:
   Ask for explicit user confirmation before reading raw datasets in `data/`,
   `data-raw/`, or `inst/extdata/`, and never commit participant-level
   sensitive data.

---

## 5. Verification (`document -> test -> check`)

Run the closed-loop package checks from the package root before concluding:
```bash
Rscript -e 'devtools::document()'
Rscript -e 'devtools::test()'
Rscript -e 'devtools::check()'
```
* Target `0 errors | 0 warnings | 0 notes`.
* Never run `grep`, `sed`, or `read_file` on rendered `.html` vignette files;
  inspect render stderr for R chunk errors (`error: true` is active by default).
