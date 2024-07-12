#import "../brilliant-CV/template.typ": *
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)

#cvSection("Publications")

#cvPublication(
  bibPath: "../src/publications.bib",
  keyList: (
    "smith2020",
    "jones2021",
    "wilson2022",
  ),
  refStyle: "apa",
)