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

#let render_lines(items, fallback: none) = {
  if items == none {
    if fallback == none { "" } else { str(fallback) }
  } else if type(items) == str {
    items
  } else if items.len() == 0 {
    if fallback == none { "" } else { str(fallback) }
  } else {
    let output = ""
    for (index, item) in items.enumerate() {
      if index > 0 {
        output += "\n"
      }
      output += str(item)
    }
    output
  }
}

#let resolve_title_page_variant(variant) = {
  // Supported variants: "1"/"simple" and "2"/"formal".
  let normalized = str(variant)
  if normalized == "1" or normalized == "simple" {
    "simple"
  } else if normalized == "2" or normalized == "formal" {
    "formal"
  } else {
    panic("Invalid title_page_variant '" + normalized + "'. Use '1'/'simple' or '2'/'formal'.")
  }
}

#let title_page(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  degree: none,
  program: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  logo: none,
  variant: "1",
) = {
  let variant_mode = resolve_title_page_variant(variant)
  let use_formal = variant_mode == "formal"
  let author_line = render_comma_list(authors)
  let affiliation_lines = render_lines(affiliations)
  let supervisor_lines = render_lines(supervisors, fallback: "-")
  let committee_lines = render_lines(committee, fallback: "-")
  let resolved_defense_date = if defense_date != none and defense_date != "" { defense_date } else { "-" }
  let resolved_date = if date != none and date != "" { date } else { "-" }

  pagebreak()

  if logo != none {
    align(right, image(logo, width: 2.5cm))
    v(1.2em)
  }

  if use_formal {
    align(center, text(22pt, weight: "bold", title))

    if subtitle != none and subtitle != "" {
      v(0.5em)
      align(center, text(12pt, subtitle))
    }

    v(1.2em)
    align(center, "Master Thesis")

    if degree != none and degree != "" {
      v(0.4em)
      align(center, degree)
    }

    if program != none and program != "" {
      align(center, program)
    }

    if institution != none and institution != "" {
      align(center, institution)
    }

    if faculty != none and faculty != "" {
      align(center, faculty)
    }

    v(1.5em)

    table(
      columns: (auto, 1fr),
      align: (left, left),
      stroke: none,
      "Author(s)", author_line,
      "Supervisor(s)", supervisor_lines,
      "Committee", committee_lines,
      "Defense date", resolved_defense_date,
      "Date", resolved_date,
    )
  } else {
    align(center, text(24pt, weight: "bold", title))

    if subtitle != none and subtitle != "" {
      v(0.6em)
      align(center, text(13pt, subtitle))
    }

    if authors != none and authors.len() > 0 {
      v(1.0em)
      align(center, author_line)
    }

    if affiliations != none and affiliations.len() > 0 {
      v(0.7em)
      align(center, affiliation_lines)
    }

    if date != none and date != "" {
      v(1.0em)
      align(center, date)
    }
  }

  pagebreak()
}
