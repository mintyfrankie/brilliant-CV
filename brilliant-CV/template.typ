/* Packages */
#import "./utils/cvHeader.typ": cvHeader, cvFooter
#import "./utils/misc.typ": hBar, setAccentColor

/* Fonts and Colors */
#let fontList = (
  "Source Sans Pro",
  "Source Sans 3",
  "Linux Libertine",
  "Font Awesome 6 Brands",
  "Font Awesome 6 Free",
)

#let headerFont = ("Roboto")

#let awesomeColors = (
  skyblue: rgb("#0395DE"),
  red: rgb("#DC3522"),
  nephritis: rgb("#27AE60"),
  concrete: rgb("#95A5A6"),
  darknight: rgb("#131A28"),
)

#let regularColors = (
  subtlegray: rgb("#ededee"),
  lightgray: rgb("#343a40"),
  darkgray: rgb("#212529"),
)


/* Functions */
#let cvSection(
  title,
  highlighted: true,
  letters: 3,
  metadata: metadata,
  awesomeColors: awesomeColors,
) = {
  let beforeSectionSkip = eval(
    metadata.layout.at("before_section_skip", default: 1pt),
  )
  let accentColor = setAccentColor(awesomeColors, metadata)
  let highlightText = title.slice(0, letters)
  let normalText = title.slice(letters)
  let sectionTitleStyle(str, color: black) = {
    text(size: 16pt, weight: "bold", fill: color, str)
  }

  v(beforeSectionSkip)
  {
    if highlighted {
      sectionTitleStyle(highlightText, color: accentColor)
      sectionTitleStyle(normalText, color: black)
    } else {
      sectionTitleStyle(title, color: black)
    }
  }
  h(2pt)
  box(width: 1fr, line(stroke: 0.9pt, length: 100%))
}

#let cvEntry(
  title: "Title",
  society: "Society",
  date: "Date",
  location: "Location",
  description: "Description",
  logo: "",
  tags: (),
  metadata: metadata,
  awesomeColors: awesomeColors,
) = {
  let accentColor = setAccentColor(awesomeColors, metadata)
  let beforeEntrySkip = eval(
    metadata.layout.at("before_entry_skip", default: 1pt),
  )
  let beforeEntryDescriptionSkip = eval(
    metadata.layout.at("before_entry_description_skip", default: 1pt),
  )

  let entryA1Style(str) = {
    text(size: 10pt, weight: "bold", str)
  }
  let entryA2Style(str) = {
    align(
      right,
      text(weight: "medium", fill: accentColor, style: "oblique", str),
    )
  }
  let entryB1Style(str) = {
    text(size: 8pt, fill: accentColor, weight: "medium", smallcaps(str))
  }
  let entryB2Style(str) = {
    align(
      right,
      text(size: 8pt, weight: "medium", fill: gray, style: "oblique", str),
    )
  }
  let entryDescriptionStyle(str) = {
    text(
      fill: regularColors.lightgray,
      {
        v(beforeEntryDescriptionSkip)
        str
      },
    )
  }
  let entryTagStyle(str) = {
    align(center, text(size: 8pt, weight: "regular", str))
  }
  let entryTagListStyle(tags) = {
    for tag in tags {
      box(
        inset: (x: 0.25em),
        outset: (y: 0.25em),
        fill: regularColors.subtlegray,
        radius: 3pt,
        entryTagStyle(tag),
      )
      h(5pt)
    }
  }

  let ifSocietyFirst(condition, field1, field2) = {
    return if condition {
      field1
    } else {
      field2
    }
  }
  let ifLogo(path, ifTrue, ifFalse) = {
    return if metadata.layout.entry.display_logo {
      if path == "" {
        ifFalse
      } else {
        ifTrue
      }
    } else {
      ifFalse
    }
  }
  let setLogoLength(path) = {
    return if path == "" {
      0%
    } else {
      4%
    }
  }
  let setLogoContent(path) = {
    return if logo == "" [] else {
      image(path, width: 100%)
    }
  }

  v(beforeEntrySkip)
  table(
    columns: (ifLogo(logo, 4%, 0%), 1fr),
    inset: 0pt,
    stroke: none,
    align: horizon,
    column-gutter: ifLogo(logo, 4pt, 0pt),
    setLogoContent(logo),
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      row-gutter: 6pt,
      align: auto,
      {
        entryA1Style(
          ifSocietyFirst(
            metadata.layout.entry.display_entry_society_first,
            society,
            title,
          ),
        )
      },
      {
        entryA2Style(
          ifSocietyFirst(
            metadata.layout.entry.display_entry_society_first,
            location,
            date,
          ),
        )
      },

      {
        entryB1Style(
          ifSocietyFirst(
            metadata.layout.entry.display_entry_society_first,
            title,
            society,
          ),
        )
      },
      {
        entryB2Style(
          ifSocietyFirst(
            metadata.layout.entry.display_entry_society_first,
            date,
            location,
          ),
        )
      },
    ),
  )
  entryDescriptionStyle(description)
  entryTagListStyle(tags)
}

#let cvSkill(type: "Type", info: "Info") = {
  let skillTypeStyle(str) = {
    align(right, text(size: 10pt, weight: "bold", str))
  }
  let skillInfoStyle(str) = {
    text(str)
  }

  table(
    columns: (16%, 1fr),
    inset: 0pt,
    column-gutter: 10pt,
    stroke: none,
    skillTypeStyle(type), skillInfoStyle(info),
  )
  v(-6pt)
}

#let cvHonor(
  date: "1990",
  title: "Title",
  issuer: "",
  url: "",
  location: "",
  awesomeColors: awesomeColors,
  metadata: metadata,
) = {
  let accentColor = setAccentColor(awesomeColors, metadata)

  let honorDateStyle(str) = {
    align(right, text(str))
  }
  let honorTitleStyle(str) = {
    text(weight: "bold", str)
  }
  let honorIssuerStyle(str) = {
    text(str)
  }
  let honorLocationStyle(str) = {
    align(
      right,
      text(weight: "medium", fill: accentColor, style: "oblique", str),
    )
  }

  table(
    columns: (16%, 1fr, 15%),
    inset: 0pt,
    column-gutter: 10pt,
    align: horizon,
    stroke: none,
    honorDateStyle(date),
    if issuer == "" {
      honorTitleStyle(title)
    } else if url != "" {
      [
        #honorTitleStyle(link(url)[#title]), #honorIssuerStyle(issuer)
      ]
    } else {
      [
        #honorTitleStyle(title), #honorIssuerStyle(issuer)
      ]
    },
    honorLocationStyle(location),
  )
  v(-6pt)
}

#let cvPublication(
  bibPath: "",
  keyList: list(),
  refStyle: "apa",
  refFull: true,
) = {
  let publicationStyle(str) = {
    text(str)
  }
  show bibliography: it => publicationStyle(it)
  bibliography(bibPath, title: none, style: refStyle, full: refFull)
}



#let letterHeader(
  myAddress: "Your Address Here",
  recipientName: "Company Name Here",
  recipientAddress: "Company Address Here",
  date: "Today's Date",
  subject: "Subject: Hey!",
  metadata: metadata,
  awesomeColors: awesomeColors,
) = {
  let accentColor = setAccentColor(awesomeColors, metadata)

  let letterHeaderNameStyle(str) = {
    text(fill: accentColor, weight: "bold", str)
  }
  let letterHeaderAddressStyle(str) = {
    text(fill: gray, size: 0.9em, smallcaps(str))
  }
  let letterDateStyle(str) = {
    text(size: 0.9em, style: "italic", str)
  }
  let letterSubjectStyle(str) = {
    text(fill: accentColor, weight: "bold", underline(str))
  }

  letterHeaderNameStyle(metadata.personal.first_name + " " + metadata.personal.last_name)
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

#let letterSignature(path) = {
  linebreak()
  place(right, dx: -5%, dy: 0%, image(path, width: 25%))
}

#let letterFooter() = {
  place(
    bottom,
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      footerStyle([#firstName #lastName]),
      footerStyle(metadata.lang.at(metadata.language).letter_footer),
    ),
  )
}

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

#let cvModule(
  metadata_path: "../metadata.toml",
  doc,
) = {
  // Load metadata
  let metadata = toml(metadata_path)

  let cvSection = cvSection.with(letter: 5)
  doc
}
)