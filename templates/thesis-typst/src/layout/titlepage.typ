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
  // Supported variants: "1"/"simple", "2"/"formal", and "3"/"custom".
  let normalized = str(variant)
  if normalized == "1" or normalized == "simple" {
    "simple"
  } else if normalized == "2" or normalized == "formal" {
    "formal"
  } else if normalized == "3" or normalized == "custom" {
    "custom"
  } else {
    panic("Invalid title_page_variant '" + normalized + "'. Use '1'/'simple', '2'/'formal', or '3'/'custom'.")
  }
}

#let resolve_title_page_image_anchor(anchor) = {
  let normalized = str(anchor)
  if normalized == "top-right" {
    top + right
  } else if normalized == "top-left" {
    top + left
  } else if normalized == "center" {
    center
  } else if normalized == "bottom-right" {
    bottom + right
  } else if normalized == "bottom-left" {
    bottom + left
  } else {
    panic("Invalid title_page_image_anchor '" + normalized + "'. Use top-right, top-left, center, bottom-right, or bottom-left.")
  }
}

#let render_title_page_image(
  image_path: none,
  anchor: "top-right",
  width: 5cm,
  height: none,
  dx: 0cm,
  dy: 0cm,
) = {
  if image_path != none {
    let placement = resolve_title_page_image_anchor(anchor)
    if height == none {
      place(placement, dx: dx, dy: dy, image(
        image_path,
        width: width,
        fit: "contain",
      ))
    } else {
      place(placement, dx: dx, dy: dy, image(
        image_path,
        width: width,
        height: height,
        fit: "contain",
      ))
    }
  } else {
    none
  }
}

#let title_page_simple_variant(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  page_image: none,
  page_image_anchor: "top-right",
  page_image_width: 5cm,
  page_image_height: none,
  page_image_dx: 0cm,
  page_image_dy: 0cm,
) = {
  let author_line = render_comma_list(authors)
  let affiliation_lines = render_lines(affiliations)

  render_title_page_image(
    image_path: page_image,
    anchor: page_image_anchor,
    width: page_image_width,
    height: page_image_height,
    dx: page_image_dx,
    dy: page_image_dy,
  )

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

#let title_page_formal_variant(
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
  page_image: none,
  page_image_anchor: "top-right",
  page_image_width: 5cm,
  page_image_height: none,
  page_image_dx: 0cm,
  page_image_dy: 0cm,
) = {
  let author_line = render_comma_list(authors)
  let supervisor_lines = render_lines(supervisors, fallback: "-")
  let committee_lines = render_lines(committee, fallback: "-")
  let resolved_defense_date = if defense_date != none and defense_date != "" { defense_date } else { "-" }
  let resolved_date = if date != none and date != "" { date } else { "-" }

  render_title_page_image(
    image_path: page_image,
    anchor: page_image_anchor,
    width: page_image_width,
    height: page_image_height,
    dx: page_image_dx,
    dy: page_image_dy,
  )

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
}

#let title_page_custom(
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
  page_image: none,
  page_image_anchor: "top-right",
  page_image_width: 5cm,
  page_image_height: none,
  page_image_dx: 0cm,
  page_image_dy: 0cm,
) = {
  // Custom entry point: replace this with your own title-page implementation.
  title_page_formal_variant(
    title,
    subtitle: subtitle,
    authors: authors,
    affiliations: affiliations,
    date: date,
    degree: degree,
    program: program,
    faculty: faculty,
    institution: institution,
    defense_date: defense_date,
    supervisors: supervisors,
    committee: committee,
    page_image: page_image,
    page_image_anchor: page_image_anchor,
    page_image_width: page_image_width,
    page_image_height: page_image_height,
    page_image_dx: page_image_dx,
    page_image_dy: page_image_dy,
  )
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
  page_image: none,
  page_image_anchor: "top-right",
  page_image_width: 5cm,
  page_image_height: none,
  page_image_dx: 0cm,
  page_image_dy: 0cm,
) = {
  let mode = resolve_title_page_variant(variant)

  pagebreak()

  if logo != none {
    align(right, image(logo, width: 2.5cm))
    v(1.2em)
  }

  if mode == "simple" {
    title_page_simple_variant(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      page_image: page_image,
      page_image_anchor: page_image_anchor,
      page_image_width: page_image_width,
      page_image_height: page_image_height,
      page_image_dx: page_image_dx,
      page_image_dy: page_image_dy,
    )
  } else if mode == "formal" {
    title_page_formal_variant(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      degree: degree,
      program: program,
      faculty: faculty,
      institution: institution,
      defense_date: defense_date,
      supervisors: supervisors,
      committee: committee,
      page_image: page_image,
      page_image_anchor: page_image_anchor,
      page_image_width: page_image_width,
      page_image_height: page_image_height,
      page_image_dx: page_image_dx,
      page_image_dy: page_image_dy,
    )
  } else {
    title_page_custom(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      degree: degree,
      program: program,
      faculty: faculty,
      institution: institution,
      defense_date: defense_date,
      supervisors: supervisors,
      committee: committee,
      page_image: page_image,
      page_image_anchor: page_image_anchor,
      page_image_width: page_image_width,
      page_image_height: page_image_height,
      page_image_dx: page_image_dx,
      page_image_dy: page_image_dy,
    )
  }

  pagebreak()
}
