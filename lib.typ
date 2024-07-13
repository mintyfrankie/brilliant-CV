/* Packages */
#import "./cv.typ": *
#import "./letter.typ": *
#import "./utils/lang.typ": *

/* Import Modules */
#let importModule(file, lang: "en") = {
  include {
    "modules_" + lang + "/" + file + ".typ"
  }
}

/* Layout */
#let cv(
  metadata,
  include_modules: list(),
  doc,
) = {
  // Non Latin Logic
  let lang = metadata.language
  let fontList = latinFontList
  let headerFont = latinHeaderFont
  if isNonLatin(lang) {
    let nonLatinFont = metadata.lang.non_latin.font
    fontList.insert(2, nonLatinFont)
    headerFont = nonLatinFont
  }

  // Page layout
  set text(font: fontList, weight: "regular", size: 9pt)
  set align(left)
  set page(
    paper: "a4",
    margin: (left: 1.4cm, right: 1.4cm, top: .8cm, bottom: .4cm),
  )

  cvHeader(metadata, headerFont, regularColors, awesomeColors)
  doc
  cvFooter(metadata)
}

#let letter(
  metadata,
  myAddress: "Your Address Here",
  recipientName: "Company Name Here",
  recipientAddress: "Company Address Here",
  date: datetime.today().display(),
  subject: "Subject: Hey!",
  signaturePath: "",
  doc,
) = {

  // Non Latin Logic
  let lang = metadata.language
  let fontList = latinFontList
  if isNonLatin(lang) {
    let nonLatinFont = metadata.lang.non_latin.font
    fontList.insert(2, nonLatinFont)
  }

  // Page layout
  set text(font: fontList, weight: "regular", size: 9pt)
  set align(left)
  set page(
    paper: "a4",
    margin: (left: 1.4cm, right: 1.4cm, top: .8cm, bottom: .4cm),
  )
  set text(size: 12pt)

  letterHeader(
    myAddress: myAddress,
    recipientName: recipientName,
    recipientAddress: recipientAddress,
    date: date,
    subject: subject,
    metadata: metadata,
    awesomeColors: awesomeColors,
  )

  doc
  if signaturePath != "" {
    letterSignature(signaturePath)
  }
  letterFooter(metadata)

}