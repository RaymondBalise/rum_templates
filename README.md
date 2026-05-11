# rum_templates

Standardized Quarto and RMarkdown templates for R projects, packages, and
presentations.

## Project Structure
- `analysis/`: Analysis templates (.qmd, .Rmd).
- `manifests/`: YAML definitions for project types and variants.
- `slides/`: Revealjs presentation templates.
- `styling/`: Custom SCSS/CSS themes.
- `supporting/`: Standard boilerplate files (e.g., `.gitignore`).

## Usage
Templates are managed via YAML manifests in `manifests/` and are typically
consumed by a scaffolding tool to initialize new projects.

## Updating Templates
To update a template, add the new file to the appropriate directory and
register it in the corresponding manifest.

### Example: Adding a new analysis style
1. Add `analysis/new_style.qmd`.
2. Update `manifests/project.yml`:
   ```yaml
   variants:
     new_variant:
       files:
         - { src: analysis/new_style.qmd, dst: analysis.qmd }
   ```
