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

#let cover_page(title, subtitle: none, authors: (), image_path: none) = {
  pagebreak()

  if image_path != none {
    align(center, image(image_path, width: 100%))
    v(1.5em)
  }

  align(center, text(28pt, weight: "bold", title))

  if subtitle != none and subtitle != "" {
    v(0.6em)
    align(center, text(14pt, subtitle))
  }

  if authors != none and authors.len() > 0 {
    v(1.2em)
    align(center, text(11pt, render_comma_list(authors)))
  }
}
