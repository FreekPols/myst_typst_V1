# Typst Options

## Layout options
- `show_cover_full` (boolean): Render a cover page.
- `show_title_page` (boolean): Render a title page.
- `show_toc` (boolean): Render the table of contents.
- `show_list_of_figures` (boolean): Render list of figures.
- `show_list_of_tables` (boolean): Render list of tables.
- `frontmatter_numbering` (`roman|none`): Numbering mode for front matter.
- `mainmatter_numbering` (`arabic|none`): Numbering mode for main matter.

## Page and typography options
- `paper_size` (string): Typst paper size, for example `a4`.
- `margin_top_cm` (number): Top margin in cm.
- `margin_bottom_cm` (number): Bottom margin in cm.
- `margin_left_cm` (number): Left margin in cm.
- `margin_right_cm` (number): Right margin in cm.
- `font_body` (string): Body font family.
- `font_mono` (string): Monospace font family.
- `font_size_pt` (number): Base font size in points.
- `line_spacing_em` (number): Paragraph leading in em.
- `toc_depth` (number): Depth for table of contents.

## Assets and title page
- `logo` (file): Header and title-page logo path.
- `cover_image` (file): Cover image path.
- `title_page_variant` (number or string): `1` or `simple` for simple, `2` or `formal` for formal.

## Shared thesis metadata (not options)
These fields are semantic metadata and should be defined in shared config, not in Typst export options:
- `project.options.thesis_degree`
- `project.options.thesis_program`
- `project.options.thesis_faculty`
- `project.options.thesis_institution`
- `project.options.thesis_defense_date`
- `project.options.thesis_supervisors`
- `project.options.thesis_committee`

At render time, MyST injects `project.options.*` into the template `options.*` object.

Variant behavior is implemented in `templates/thesis-typst/src/layout/titlepage.typ`.

## Active export config
- Single export profile: `config/exports/typst_config.yml`.
