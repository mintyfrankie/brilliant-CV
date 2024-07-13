/* Packages */
#import "./cv.typ": *
#import "./letter.typ": *
#import "./utils/lang.typ": *

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

  let importModule(file, lang) = {
    include {
      "/modules_" + lang + "/" + file + ".typ"
    }
  }

  cvHeader(metadata, headerFont, regularColors, awesomeColors)
  for i in include_modules {
    importModule(i, metadata.language)
  }
  doc
  cvFooter(metadata)
}

#let letter(
  metadata_path: "../metadata.toml",
  myAddress: "Your Address Here",
  recipientName: "Company Name Here",
  recipientAddress: "Company Address Here",
  date: datetime.today().display(),
  subject: "Subject: Hey!",
  signaturePath: "",
  doc,
) = {

  // Load metadata
  let metadata = toml(metadata_path)

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