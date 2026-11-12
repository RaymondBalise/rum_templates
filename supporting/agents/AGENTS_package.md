# Package Guidelines for AI Coding Assistants (`AGENTS.md`)

This repository is an `{rUM}` R package with a vignette manuscript. Follow
these R package architecture, data privacy, and `R CMD check` standards on
every task.

---

## 1. Package Directory & File Routing

* **`R/` (Exported & Internal Package Functions)**:
  * Every reusable function and dataset documentation block lives in `R/`.
  * **Never** call `library()`, `require()`, `source()`, or `setwd()` inside
    `R/` files. Declare dependencies in `DESCRIPTION` via
    `usethis::use_package()` and reference functions with `pkg::fn()` or
    `@importFrom`.
  * Document exported functions with `roxygen2` headers and regenerate
    `NAMESPACE` and `man/*.Rd` via `devtools::document()`. Document package
    datasets with `rUM::write_man()`.
* **`vignettes/` (Manuscripts & Citations)**:
  * Vignette manuscripts (`vignettes/analysis.qmd` or `vignettes/analysis.Rmd`)
    reference citations and bundled `.csl` files inside `vignettes/bib/`
    (`bib/apa.csl` default, `bib/mla.csl`,
    `bib/the-new-england-journal-of-medicine.csl`).
  * Never run `grep`, `sed`, or `read_file` on rendered `.html` vignette files
    (base64 assets produce multi-megabyte lines). Inspect render stderr output
    for R chunk errors (`error: true` in starter templates allows failed chunks
    to exit `0`).
* **`inst/` (External Data & Pipeline Scripts)**:
  * Place analysis pipeline scripts in `inst/scripts/` (`libraries.R`,
    `do_everything.R`) and non-`.rda` files (`.rds`, `.xlsx`, `.parquet`,
    `.csv`) in `inst/extdata/`.
* **`data/` & `data-raw/` (Data & PHI Boundary)**:
  * Reserve `data/` strictly for documented `.rda` package objects created via
    `usethis::use_data()` + `rUM::write_man()`. Ask for explicit user
    confirmation before reading raw files in `inst/extdata/`, `data/`, or
    `data-raw/`, and never commit participant-level PHI data.
* **`tests/testthat/` & `.Rbuildignore`**:
  * Place unit tests in `tests/testthat/`. Keep non-package root files (such
    as `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.agents`, and `DECISIONS.md`)
    listed in `.Rbuildignore` so `R CMD check` passes with zero NOTEs.

---

## 2. R & Quarto Coding Standards

* **Modern R Idioms**:
  * Use the native R pipe `|>` (never `%>%`), `snake_case` names, and double
    quotes (`"`). Prefix non-exported helpers with `.` (e.g., `.clean_cols()`).
  * Wrap all R code, comments, and `roxygen2` lines at or below **80
    characters**.
  * Prefer `withr::local_*()` for temporary state and `testthat` 3e idioms.
* **Quarto Vignette Chunks (`.qmd`)**:
  * Adapt to the chunk-option style already used in the `.qmd` vignette
    (`{r label}` headers vs `#| label:` hashpipes) without rewriting existing
    chunk headers unprompted. Only on blank `.qmd` files or when asked, mention
    the 1-line `#| label:` (Quarto YAML standard) vs `{r label}` (collapsed
    chunk visibility in RStudio/Positron) trade-off.

---

## 3. Built-In Package Skills (`.agents/skills/`)

1. **`rum-workflow`** (`.agents/skills/rum-workflow/SKILL.md`):
   Adding package functions, `roxygen2` / dataset docs (`rUM::write_man()`),
   vignettes, slide decks (`rUM::write_slides(path = "inst")`), `.csl` styles,
   and running `devtools::check()`.
2. **`rum-devlog`** (`.agents/skills/rum-devlog/SKILL.md`):
   Auditing code comments, recording architectural or analytical decisions in
   `DECISIONS.md`, and maintaining `NEWS.md`.
3. **`rum-commit`** (`.agents/skills/rum-commit/SKILL.md`):
   Drafting structured git commit messages (`type(scope): summary` `<= 72`
   chars with 2-space indented bullets and zero AI attribution trailers).
