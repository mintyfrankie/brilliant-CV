/*
* Functions for the CV template
*/

#import "./utils/styles.typ": *

/// Insert the header section of the letter.
#let letter-header(
  my-address: "Your Address Here",
  recipient-name: "Company Name Here",
  recipient-address: "Company Address Here",
  date: datetime.today().display(),
  subject: "Subject: Hey!",
  metadata: metadata,
  awesome-colors: awesome-colors,
) = {
  let accent-color = set-accent-color(awesome-colors, metadata)
  let first-name = metadata.personal.first_name
  let last-name = metadata.personal.last_name

  let letter-header-name-style(str) = {
    text(fill: accent-color, weight: "bold", str)
  }
  let letter-header-address-style(str) = {
    text(fill: gray, size: 0.9em, smallcaps(str))
  }
  let letter-date-style(str) = {
    text(size: 0.9em, style: "italic", str)
  }
  let letter-subject-style(str) = {
    text(fill: accent-color, weight: "bold", underline(str))
  }

  letter-header-name-style(first-name + " " + last-name)
  v(1pt)
  letter-header-address-style(my-address)
  v(1pt)
  align(right, letter-header-name-style(recipient-name))
  v(1pt)
  align(right, letter-header-address-style(recipient-address))
  v(1pt)
  letter-date-style(date)
  v(1pt)
  letter-subject-style(subject)
  linebreak()
  linebreak()
}

#let letter-signature(img) = {
  set image(width: 25%)
  linebreak()
  place(right, dx: -5%, dy: 0%, img)
}

#let letter-footer(metadata) = {
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
