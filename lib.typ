/*
* Entry point for the package
*/

/* Packages */
#import "./cv.typ": *
#import "./letter.typ": *
#import "./utils/lang.typ": *

/* Layout */
#let cv(
  metadata, 
  profile-photo: image("./template/src/avatar.png"),
  doc) = {
  // Non Latin Logic
  let lang = metadata.language
  let font-list = latin-font-list
  let header-font = latinheader-font
  if is-non-latin(lang) {
    let non-latin-font = metadata.lang.non_latin.font
    font-list.insert(2, non-latin-font)
    header-font = non-latin-font
  }

  // Page layout
  set text(font: font-list, weight: "regular", size: 9pt)
  set align(left)
  set page(
    paper: "a4",
    margin: (left: 1.4cm, right: 1.4cm, top: .8cm, bottom: .4cm),
  )

  cv-header(metadata, profile-photo, header-font, regular-colors, awesome-colors)
  doc
  cv-footer(metadata)
}

#let letter(
  metadata,
  doc,
  my-address: "Your Address Here",
  recipient-name: "Company Name Here",
  recipient-address: "Company Address Here",
  date: datetime.today().display(),
  subject: "Subject: Hey!",
  signature: "",
) = {
  // Non Latin Logic
  let lang = metadata.language
  let font-list = latin-font-list
  if is-non-latin(lang) {
    let non-latin-font = metadata.lang.non_latin.font
    font-list.insert(2, non-latin-font)
  }

  // Page layout
  set text(font: font-list, weight: "regular", size: 9pt)
  set align(left)
  set page(
    paper: "a4",
    margin: (left: 1.4cm, right: 1.4cm, top: .8cm, bottom: .4cm),
  )
  set text(size: 12pt)

  letter-header(
    my-address: my-address,
    recipient-name: recipient-name,
    recipient-address: recipient-address,
    date: date,
    subject: subject,
    metadata: metadata,
    awesome-colors: awesome-colors,
  )

  doc

  if signature != "" {
    letter-signature(signature)
  }
  letter-footer(metadata)
}
