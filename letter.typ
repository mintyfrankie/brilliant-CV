/*
* Functions for the CV template
*/

#import "./utils/styles.typ": *

/// Insert the header section of the letter.
#let _letterHeader(
  myAddress: "Your Address Here",
  recipientName: "Company Name Here",
  recipientAddress: "Company Address Here",
  date: datetime.today().display(),
  subject: "Subject: Hey!",
  metadata: metadata,
  awesome-colors: awesome-colors,
) = {
  let accent-color = set-accent-color(awesome-colors, metadata)
  let first-name = metadata.personal.first_name
  let last-name = metadata.personal.last_name

  let letterHeaderNameStyle(str) = {
    text(fill: accent-color, weight: "bold", str)
  }
  let letterHeaderAddressStyle(str) = {
    text(fill: gray, size: 0.9em, smallcaps(str))
  }
  let letterDateStyle(str) = {
    text(size: 0.9em, style: "italic", str)
  }
  let letterSubjectStyle(str) = {
    text(fill: accent-color, weight: "bold", underline(str))
  }

  letterHeaderNameStyle(first-name + " " + last-name)
  v(1pt)
  letterHeaderAddressStyle(myAddress)
  v(1pt)
  align(right, letterHeaderNameStyle(recipientName))
  v(1pt)
  align(right, letterHeaderAddressStyle(recipientAddress))
  v(1pt)
  letterDateStyle(date)
  v(1pt)
  letterSubjectStyle(subject)
  linebreak()
  linebreak()
}

#let _letterSignature(img) = {
  set image(width: 25%)
  linebreak()
  place(right, dx: -5%, dy: 0%, img)
}

#let _letterFooter(metadata) = {
  // Parameters
  let first-name = metadata.personal.first_name
  let last-name = metadata.personal.last_name
  let footer-text = metadata.lang.at(metadata.language).letter_footer

  // Styles
  let footer-style(str) = {
    text(size: 8pt, fill: rgb("#999999"), smallcaps(str))
  }

  place(
    bottom,
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      footer-style([#first-name #last-name]),
      footer-style(metadata.lang.at(metadata.language).letter_footer),
    ),
  )
}
