# MyST + Typst Thesis Scaffold

This project keeps one shared metadata source for MyST and Typst while isolating PDF layout in a Typst template.

## Build
- Single profile build: `myst build --typst`

## Shared vs PDF-only configuration
- Shared semantics: `config/config.yml`, `config/people.yml`, and `parts/*.md`
- Thesis semantic fields live under `project.options.thesis_*` in shared config.
- PDF layout knobs: `config/exports/typst_config.yml`
- Cover options are split from title-page options (`cover_background_image` vs `title_page_image`).
- Variant entry points exist in `templates/thesis-typst/src/layout/cover.typ` and `templates/thesis-typst/src/layout/titlepage.typ`.
- Typst rendering logic: `templates/thesis-typst/src/*`
- Part-file references for export are declared in `myst.yml` via `project.parts.*`.
