/* Packages */
#import "./cv.typ": *

/* Layout */
#let cv(
  metadata_path: "../metadata.toml",
  include_modules: list(),
  doc,
) = {
  // Load metadata
  let metadata = toml(metadata_path)

  // Page layout
  set text(font: fontList, weight: "regular", size: 9pt)
  set align(left)
  set page(
    paper: "a4",
    margin: (left: 1.4cm, right: 1.4cm, top: .8cm, bottom: .4cm),
  )

  let importModule(file, lang) = {
    include {
      "../modules_" + lang + "/" + file + ".typ"
    }
  }

  cvHeader(metadata, headerFont, regularColors, awesomeColors)
  for i in include_modules {
    importModule(i, metadata.language)
  }
  doc
  cvFooter(metadata)
}