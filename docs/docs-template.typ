#let template(
  title: "",
  subtitle: "",
  authors: "",
  date: "",
  version: "",
  doc,
) = {
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Source Sans 3", lang: "en")

  doc
}
