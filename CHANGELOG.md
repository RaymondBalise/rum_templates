# Changelog

All notable changes to `rum_templates` are documented in this file. Release
numbers correspond to the `template-version` YAML key in scaffolded `.qmd` and
`.Rmd` templates consumed by `{rUM}` (`v2.4.0+`).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [1] - 2026-11-12

### Added
- YAML manifests (`manifests/{project,package,slides,quarto_standalone}.yml`)
  defining file mappings, `inject` partial tokens, and setup actions for
  `{rUM}` `v2.4.0+`.
- Core Quarto (`.qmd`) and R Markdown (`.Rmd`) analysis, vignette, standalone,
  and Revealjs slide templates (`default`, `miami`, and `rmed` themes) carrying
  `template-version: 1` in YAML frontmatter.
- Shared `knitr` partial snippets in `supporting/partials/`
  (`knitr_analysis.yml`, `knitr_slides.yml`, `knitr_rmd.Rmd`) injected via
  `{{knitr_opts}}` at scaffold time.
- Bundled Zotero citation styles in `supporting/` (`apa.csl` APA 7th default,
  `mla.csl` MLA 9th, and `the-new-england-journal-of-medicine.csl` NEJM),
  scaffolded alongside `.bib` files inside `bib/` (`vignettes/bib/` for
  packages).
- Built-in AI coding assistant instructions (`AGENTS.md`, `CLAUDE.md`,
  `GEMINI.md`) tracked at repository root and in `supporting/agents/` alongside
  `.agents/skills/` (`rum-workflow`, `rum-devlog`, `rum-commit`) tailored to
  `{rUM}` analysis projects and R packages.
- Package starter directories and scripts (`inst/extdata/`,
  `inst/scripts/libraries.R`, `inst/scripts/do_everything.R`, and
  `supporting/vignettes_gitignore.md`) in `manifests/package.yml`.
- Default example Revealjs slide template (`slides/quarto_slides_example.qmd`),
  dev-first `read_extdata()` dataset loader and `library(arrow)` in vignette
  templates, plus R/Medicine slide artwork in `styling/img/` and
  `styling/clean_title_page.html`.
- Starter `styling/custom.scss` stylesheet for `rUM::write_scss()` and
  `rUM::write_quarto(example = ...)` scaffolding.

### Changed
- Renamed `supporting/aggressive_gitignore.md` to `supporting/.gitignore.md`,
  added `*.arrow` and SAS (`*.sas7bndx`, `*.xpt`, `*.sd2`, `*.sd7`, `*.ssd*`)
  ignore patterns, and negated `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and
  `.agents/skills/**`.
- Updated `supporting/README.md` to reference `DECISIONS.md` and `CHANGELOG.md`
  (or `NEWS.md` for packages) in place of `dated_progress_notes.md`.
- Standardized all Revealjs slide templates on `echo: false`,
  `link-external-newwindow: true`, and `link-external-icon: false` (with inline
  YAML hint), and added `link-external-newwindow: true` across HTML Quarto
  templates.

### Fixed
- Replaced legacy R Markdown `output: rmarkdown::html_vignette` in Quarto
  vignette templates with `format: html`.
- Switched R Markdown vignette templates to `bookdown::html_vignette2`
  (`number_sections: false`) so `\@ref()` table and figure cross-references
  resolve.
- Added placeholder table and figure outputs across `*_wo_example.{qmd,Rmd}`
  templates so `@tbl-table1`, `@fig-figure-1`, `\@ref(tab:table-1)`, and
  `\@ref(fig:figure1)` resolve without warnings on initial render.
- Guarded `library(arrow)` with `requireNamespace()` in vignette templates,
  preserved existing `@R-*` package entries when updating `bib/packages.bib`,
  scoped `read_extdata()` to `inst/extdata/` (removing pre-created `data/` in
  `package.yml` and trailing comma in `dataset_names`), and fixed `fig.width` /
  `fig.height` option names in `knitr_analysis.yml`.
- Expanded `.gitignore` (`*_files/`, `!**/clean_title_page.html`, database and
  delimited PHI patterns, `data-raw/`, `raw-data/`), guarded `libraries.R`
  auto-installs, commented optional `import.R` / `preprocess.R` entries in
  `do_everything.R`, aligned `AGENTS_*.md` / `rum-workflow` chunk and render
  checks, and fixed slide `data-background-opacity: "0.5"` and prose typos.
- Removed runtime `download_csl` and `download_rmed_artwork` manifest actions
  in favor of bundled scaffold copies.
