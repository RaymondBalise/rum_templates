# Project Guidelines for AI Coding Assistants (`AGENTS.md`)

This project follows the `{rUM}` research project architecture for R, Quarto,
and R Markdown. Follow these file routing, data privacy, and coding rules on
every task.

---

## 1. Directory & File Routing

* **`analysis.qmd` / `analysis.Rmd` (Primary Manuscript)**:
  * Keep narrative code chunks focused on loading prepared objects, displaying
    `gtsummary` / `table1` tables, rendering `ggplot2` figures, and inline
    statistics.
  * Citations live in `bib/` (`bib/references.bib` and `bib/packages.bib`).
    Switch citation styles in YAML frontmatter via `csl:` (`bib/apa.csl`
    default, `bib/mla.csl`, or `bib/the-new-england-journal-of-medicine.csl`).
  * Standalone Quarto HTML outputs (`embed-resources: true`) encode fonts and
    images onto multi-megabyte lines. Never run `grep`, `sed`, or `read_file`
    on rendered `.html` files; inspect `quarto render` / `rmarkdown::render()`
    stderr output for R chunk errors (starter templates set `error: true`, so a
    failed chunk can still return exit code `0`).
* **`R/` (Modular Scripts & Helpers)**:
  * As the analysis grows, extract heavy data cleaning, feature engineering,
    and modeling into modular scripts inside `R/` (e.g., `R/clean_data.R`,
    `R/models.R`) and `source(here::here("R", "..."))` from the manuscript.
* **`data/` (Protected Data Directory)**:
  * Raw and processed datasets live in `data/` and are gitignored by default
    via `{rUM}`'s aggressive `.gitignore` to protect sensitive/PHI data.
  * **Privacy Gate**: Ask for explicit user confirmation before reading raw
    data files in `data/` (`.rds`, `.rda`, `.csv`, `.xlsx`, `.parquet`), and
    never stage or commit participant-level data to version control.
* **`custom.scss` & `slides/`**:
  * In Quarto projects (`analysis.qmd`), customize HTML styling in `custom.scss`
    (or create new stylesheets with `rUM::write_scss()`). Slide decks live in
    `slides/` via `rUM::write_slides()`.

---

## 2. R & Quarto Coding Standards

* **Path Discipline (`here::here()`)**:
  * Construct all file paths with `here::here()` (e.g.,
    `rio::import(here::here("data", "clean.rds"))`). Never call `setwd()`.
* **Modern R Idioms**:
  * Use the native R pipe `|>` (never `%>%`), `snake_case` names, and double
    quotes (`"`).
  * Wrap all R code and comments at or below **80 characters** per line.
  * Resolve namespace collisions explicitly with `conflicted::conflict_prefer()`
    or `tidymodels::tidymodels_prefer()`.
  * Prefer modern `dplyr` 1.1+ idioms (inline `.by =` and `join_by()`).
* **Quarto (`.qmd`) Chunk Formatting**:
  * Adapt to the chunk-option style already used in the `.qmd` file (`{r label}`
    chunk headers with `#| tbl-cap:` / `#| fig-cap:` in the body, or pure `#|`
    hashpipes) and never rewrite existing chunk headers unprompted.
  * Only when creating a blank `.qmd` file or when asked about chunk style,
    share a 1-line note on the trade-off (`#| label:` is the Quarto YAML
    standard; `{r label}` keeps chunk names visible when collapsed in
    RStudio/Positron) and follow the user's preference. Use `tbl-` and `fig-`
    label prefixes for Quarto cross-references.

---

## 3. Built-In Project Skills (`.agents/skills/`)

1. **`rum-workflow`** (`.agents/skills/rum-workflow/SKILL.md`):
   Adding Quarto documents (`rUM::write_quarto()`), modular `R/` scripts,
   `custom.scss` themes (`rUM::write_scss()`), slide decks
   (`rUM::write_slides()`), and switching `.csl` citation styles.
2. **`rum-devlog`** (`.agents/skills/rum-devlog/SKILL.md`):
   Auditing code comments, logging analytical decisions in `DECISIONS.md`, and
   updating `CHANGELOG.md`.
3. **`rum-commit`** (`.agents/skills/rum-commit/SKILL.md`):
   Drafting structured git commit messages (`type(scope): summary` `<= 72`
   chars with 2-space indented bullets and zero AI attribution trailers).
