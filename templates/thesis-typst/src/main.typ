#import "layout/cover.typ": cover_page
#import "layout/titlepage.typ": title_page
#import "layout/frontmatter.typ": frontmatter_section
#import "layout/toc.typ": render_table_of_contents, render_list_of_figures, render_list_of_tables
#import "components/headings.typ": configure_headings
#import "components/figures.typ": configure_figures
#import "components/tables.typ": configure_tables
#import "theme/page.typ": (
  default_paper_size,
  default_margin_top,
  default_margin_bottom,
  default_margin_left,
  default_margin_right,
  default_toc_depth,
  default_frontmatter_numbering,
  default_mainmatter_numbering,
)
#import "theme/typography.typ": default_font_body, default_font_mono, default_font_size
#import "theme/colors.typ": default_text_color, default_heading_color
#import "theme/spacing.typ": default_line_spacing, default_par_spacing

#let require_non_empty(value, field_name, fallback: none) = {
  if value == none or value == "" {
    if fallback != none {
      fallback
    } else {
      panic("Missing required metadata: " + field_name)
    }
  } else {
    value
  }
}

#let resolve_numbering(mode, default: "1") = {
  if mode == none {
    default
  } else if mode == "none" {
    none
  } else if mode == "roman" {
    "i"
  } else if mode == "arabic" {
    "1"
  } else {
    default
  }
}

#let resolve_asset_path(path, levels_up: 1) = {
  if path == none {
    none
  } else if type(path) != str {
    path
  } else if path.starts-with("/") or path.starts-with("./") or path.starts-with("../") or path.contains(":/") {
    path
  } else if levels_up == 2 {
    "../../" + path
  } else if levels_up == 1 {
    "../" + path
  } else {
    path
  }
}

#let render_comma_list(items) = {
  if items == none {
    ""
  } else if type(items) == str {
    items
  } else if items.len() == 0 {
    ""
  } else {
    let output = ""
    for (index, item) in items.enumerate() {
      if index > 0 {
        output += ", "
      }
      output += str(item)
    }
    output
  }
}

#let thesis_template(
  title: "Untitled Thesis",
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  keywords: (),
  thesis_degree: none,
  thesis_program: none,
  thesis_faculty: none,
  thesis_institution: none,
  thesis_defense_date: none,
  thesis_supervisors: none,
  thesis_committee: none,
  abstract: none,
  preface: none,
  acknowledgements: none,
  dedication: none,
  colophon: none,
  show_cover_full: true,
  show_title_page: true,
  show_toc: true,
  show_list_of_figures: false,
  show_list_of_tables: false,
  frontmatter_numbering: default_frontmatter_numbering,
  mainmatter_numbering: default_mainmatter_numbering,
  paper_size: default_paper_size,
  margin_top_cm: default_margin_top,
  margin_bottom_cm: default_margin_bottom,
  margin_left_cm: default_margin_left,
  margin_right_cm: default_margin_right,
  font_body: default_font_body,
  font_mono: default_font_mono,
  font_size_pt: default_font_size,
  line_spacing_em: default_line_spacing,
  toc_depth: default_toc_depth,
  logo: none,
  cover_image: none,
  title_page_variant: "1",
  body,
) = {
  let resolved_title = require_non_empty(title, "project.title", fallback: "Untitled Thesis")
  let front_numbering = resolve_numbering(frontmatter_numbering, default: "i")
  let main_numbering = resolve_numbering(mainmatter_numbering, default: "1")
  let resolved_logo_for_main = resolve_asset_path(logo, levels_up: 1)
  let resolved_logo_for_layout = resolve_asset_path(logo, levels_up: 2)
  let resolved_cover_image = resolve_asset_path(cover_image, levels_up: 2)

  set page(
    paper: paper_size,
    margin: (
      top: margin_top_cm,
      bottom: margin_bottom_cm,
      left: margin_left_cm,
      right: margin_right_cm,
    ),
    numbering: front_numbering,
  )

  set text(
    font: font_body,
    size: font_size_pt,
    fill: default_text_color,
  )

  set par(
    leading: line_spacing_em,
    spacing: default_par_spacing,
    justify: true,
  )

  show raw: set text(font: font_mono, size: font_size_pt - 1pt)

  configure_headings(default_heading_color)
  configure_figures()
  configure_tables()

  if show_cover_full {
    cover_page(
      resolved_title,
      subtitle: subtitle,
      authors: authors,
      image_path: resolved_cover_image,
    )
  }

  if show_title_page {
    title_page(
      resolved_title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      degree: thesis_degree,
      program: thesis_program,
      faculty: thesis_faculty,
      institution: thesis_institution,
      defense_date: thesis_defense_date,
      supervisors: thesis_supervisors,
      committee: thesis_committee,
      logo: resolved_logo_for_layout,
      variant: title_page_variant,
    )
  }

  frontmatter_section("Abstract", abstract)
  frontmatter_section("Preface", preface)
  frontmatter_section("Acknowledgements", acknowledgements)
  frontmatter_section("Dedication", dedication)
  frontmatter_section("Colophon", colophon)
  frontmatter_section("Keywords", render_comma_list(keywords))

  if show_toc {
    render_table_of_contents(depth: toc_depth)
  }

  if show_list_of_figures {
    render_list_of_figures()
  }

  if show_list_of_tables {
    render_list_of_tables()
  }

  pagebreak()

  set page(
    paper: paper_size,
    margin: (
      top: margin_top_cm,
      bottom: margin_bottom_cm,
      left: margin_left_cm,
      right: margin_right_cm,
    ),
    numbering: main_numbering,
    header: if resolved_logo_for_main != none {
      align(right, image(resolved_logo_for_main, width: 1.4cm))
    } else {
      none
    },
  )

  counter(page).update(1)

  [#body]
}
