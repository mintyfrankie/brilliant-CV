#import "metadata.typ": *

/* Layout */

#let layout(doc) = {
  set text(font: "Source Sans Pro")
  set align(left)
  set page(
    paper: "a4",
    margin: (
      left: 1.4cm,
      right: 1.4cm,
      top: .8cm,
      bottom: .8cm,
    ),
  )
  doc
}

/* Styles */

#let accentColor = rgb("#0395DE")
#let headerFont = "Roboto"
#let bodyFont = "Source Sans Pro"

#let beforeSectionSkip = 6pt
#let beforeEntrySkip = 6pt

#let headerFirstNameStyle(str) = {text(
  font: headerFont,
  size: 32pt,
  weight: "light",
  fill: gray,
  str
)}

#let headerLastNameStyle(str) = {text(
  font: headerFont,
  size: 32pt,
  weight: "semibold",
  str
)}

#let headerInfoStyle(str) = {text(
  font: (bodyFont, "Font Awesome 6 Brands", "Font Awesome 6 Free"),
  size: 10pt,
  fill: accentColor,
  str
)}

#let sectionTitleStyle(str, color:black) = {text(
  font: bodyFont, 
  size: 16pt, 
  weight: "bold", 
  fill: color,
  str
)}

#let entryA1Style(str) = {text(
  font: bodyFont,
  size: 10pt,
  weight: "bold",
  str
)}

// FIXME: temporary fix on align
#let entryA2Style(str) = {align(right, text(
  font: bodyFont,
  size: 9pt,
  weight: "light",
  fill: accentColor,
  style: "oblique",
  str
))}

#let entryB1Style(str) = {text(
  font: bodyFont,
  size: 8pt,
  weight: "regular",
  smallcaps(str)
)}

// FIXME: temporary fix on align
#let entryB2Style(str) = {align(right, text(
  font: bodyFont,
  size: 8pt,
  weight: "regular",
  fill: gray,
  style: "oblique",
  str
))}

#let entryDescriptionStyle(str) = {text(
  font: bodyFont,
  size: 8pt,
  weight: "regular",
  str
)}


// FIXME: temporary fix on align
#let skillTypeStyle(str) = {align(right, text(
  font: bodyFont,
  size: 10pt,
  weight: "bold",
  str))
}

#let skillInfoStyle(str) = {text(
  font: bodyFont,
  size: 9pt,
  weight: "light",
  str
)}

#let footerStyle(str) = {text(
  font: bodyFont,
  size: 8pt,
  weight: "regular",
  fill: gray,
  smallcaps(str)
)}

/* Functions */

#let makeHeaderInfo() = {
  let personalInfoIcons = (
    phone: [\u{f2c1}],
    email: [\u{f0e0}],
    linkedin: [\u{f08c}],
    homepage: [\u{1f5d6}],
    github: [\u{f092}],
    extraInfo: "",
  )
  let n = 1
  for (k, v) in personalInfo {
    if v != "" {
      // Adds hBar
      if n != 1 {
        h(5pt) + "|" + h(5pt)
      }
      
      // Adds icons
      personalInfoIcons.at(k) + h(5pt)

      // Adds hyperlinks
      if k == "email" {
        link("mailto:" + v)[#v]
      } else if k == "linkedin" {
        link("https://www.linkedin.com/in/" + v)[#v]
      } else if k == "github" {
        link("https://github.com/" + v)[#v]
      } else if k == "homepage" {
        link("https://" + v)[#v]
      } else {
        v
      }
    }
    n = n + 1
  }
}

#let cvHeader(imagePath: "") = {
  table(
    columns: (auto, 20%),
    inset: 0pt,
    stroke: none,
    align: horizon,
    {
      table(
        columns: 1fr,
        inset: 0pt,
        stroke: none,
        row-gutter: 6mm,
        [
          #headerFirstNameStyle(firstName) #h(5pt) #headerLastNameStyle(lastName)
        ],
        [
          #headerInfoStyle(makeHeaderInfo())
        ]
      )
    },
    {
      if profilePhoto != "" {
        image(profilePhoto, height: 3.6cm)
      } else {
        rect(height: 3.6cm, stroke: none)
      }
    }
  )
}

#let cvSection(title) = {
  let highlightText = title.slice(0,3)
  let normalText = title.slice(3)

  v(beforeSectionSkip)
  sectionTitleStyle(highlightText, color: accentColor)
  sectionTitleStyle(normalText, color: black)
  h(2pt)
  box(width: 1fr, line(stroke: 0.9pt, length: 100%))
}

#let cvEntry(
  title: "Title",
  society: "Society",
  date: "Date",
  location: "Location",
  description: "Description",
) = {

  v(beforeEntrySkip)
  table(
    columns: (1fr, auto),
    inset: 0pt,
    stroke: none,
    row-gutter: 6pt,
    align: auto,
    {entryA1Style(title)},
    {entryA2Style(date)},
    {entryB1Style(society)},
    {entryB2Style(location)},
  )
  entryDescriptionStyle(description)
}

#let cvSkill(
  type: "Type",
  info: "Info",
) = {
  table(
    columns: (16%, 1fr),
    inset: 0pt,
    column-gutter: 10pt,
    stroke: none,
    skillTypeStyle(type),
    skillInfoStyle(info),
  )
  v(-6pt)
}

#let cvFooter() = {
  place(
    bottom,
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      footerStyle([#firstName #lastName]),
      footerStyle([Résumé]),
    )
  )
}

// Utilities

#let hBar() = [
  #h(5pt) | #h(5pt)
]

