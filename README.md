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

### Manifest Schema
- `name`: Unique identifier for the template type.
- `description`: A brief summary of the template's purpose.
- `common`: (Optional) Files and actions shared by all variants.
- `variants`: Definitions for specific template configurations.
- `when`: Conditions (e.g., `format`, `example`) that trigger a variant.
- `files`: A list of file mappings for the template:
  - `src`: Path to the source template file in this repository.
  - `dst`: Target path in the new project (supports placeholders).
- `actions`: Post-initialization tasks:
  - `type`: The action to perform (e.g., `create_dir`, `download_csl`,
    `build_description`, `write_scss`).
  - `path`: (Optional) The directory target for the action.
- `metadata`: (Optional) Key-value pairs for additional configuration (e.g.,
  `vignette_builder`).

### Example: Adding a new analysis style
1. Add `analysis/new_style.qmd`.
2. Update `manifests/project.yml`:
   ```yaml
   variants:
     new_variant:
       files:
         - { src: analysis/new_style.qmd, dst: analysis.qmd }
   ```
