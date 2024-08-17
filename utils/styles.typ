/*
A module containing functions for styling.
*/

#let h-bar() = [#h(5pt) | #h(5pt)]

#let latin-font-list = (
  "Source Sans Pro",
  "Source Sans 3",
  "Linux Libertine",
  "Font Awesome 6 Brands",
  "Font Awesome 6 Free",
)

#let latin-header-font = ("Roboto")

#let awesome-colors = (
  skyblue: rgb("#0395DE"),
  red: rgb("#DC3522"),
  nephritis: rgb("#27AE60"),
  concrete: rgb("#95A5A6"),
  darknight: rgb("#131A28"),
)

#let regular-colors = (
  subtlegray: rgb("#ededee"),
  lightgray: rgb("#343a40"),
  darkgray: rgb("#212529"),
)

#let set-accent-color(awesome-colors, metadata) = {
  let param = metadata.layout.awesome_color
  return if param in awesome-colors {
    awesome-colors.at(param)
  } else {
    rgb(param)
  }
}
