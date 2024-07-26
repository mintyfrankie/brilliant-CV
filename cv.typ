/*
* Functions for the CV template
*/

#import "@preview/fontawesome:0.2.1": *
#import "./utils/injection.typ": inject
#import "./utils/styles.typ": hBar, latinFontList, latinHeaderFont, awesomeColors, regularColors, setAccentColor
#import "./utils/lang.typ": isNonLatin

/// Insert the header section of the CV.
///
/// - metadata (array): the metadata read from the TOML file.
/// - headerFont (array): the font of the header.
/// - regularColors (array): the regular colors of the CV.
/// - awesomeColors (array): the awesome colors of the CV.
/// -> content
#let _cvHeader(
  metadata,
  profilePhoto,
  headerFont,
  regularColors,
  awesomeColors,
) = {
  // Parameters
  let showProfilePhoto = metadata.layout.header.at(
    "display_profile_photo",
    default: true,
  )
  let headerAlign = eval(
    metadata.layout.header.at("header_align", default: "left"),
  )
  let isInjectAIPromptEnabled = metadata.inject.at(
    "inject_ai_prompt",
    default: false,
  )
  let isInjectKeywordsEnabled = metadata.inject.at(
    "inject_keywords",
    default: false,
  )
  let injectedKeywordsList = metadata.inject.at(
    "injected_keywords_list",
    default: (),
  )
  let personalInfo = metadata.personal.info
  let firstName = metadata.personal.first_name
  let lastName = metadata.personal.last_name
  let headerQuote = metadata.lang.at(metadata.language).header_quote
  let accentColor = setAccentColor(awesomeColors, metadata)

  // Non Latin Logic
  let nonLatinName = ""
  let nonLatin = isNonLatin(metadata.language)
  if nonLatin {
    nonLatinName = metadata.lang.non_latin.name
  }

  // Components
  let drawPersonalInfoSection(personalInfo: personalInfo) = {
    let infoSections = (
      phone: (icon: fa-phone(), linkPrefix: "tel:"),
      email: (icon: fa-envelope(), linkPrefix: "mailto:"),
      linkedin: (
        icon: fa-linkedin(),
        linkPrefix: "https://www.linkedin.com/in/",
      ),
      homepage: (icon: fa-pager(), linkPrefix: "https://"),
      github: (icon: fa-square-github(), linkPrefix: "https://github.com/"),
      gitlab: (icon: fa-gitlab(), linkPrefix: "https://gitlab.com/"),
      orcid: (icon: fa-orcid(), linkPrefix: "https://orcid.org/"),
      researchgate: (
        icon: fa-researchgate(),
        linkPrefix: "https://www.researchgate.net/profile/",
      ),
      location: (icon: fa-location-dot(), linkPrefix: ""),
      extraInfo: (icon: "", linkPrefix: ""),
    )
    // Loop through personalInfo to draw each info section
    let n = 1
    for (k, v) in personalInfo {
      // If the key contains "custom", it means it is a custom section
      if k.contains("custom") {
        let img = v.at("image", default: "")
        let awesomeIcon = v.at("awesomeIcon", default: "")
        let text = v.at("text", default: "")
        let linkValue = v.at("link", default: "")
        let icon = ""
        if img != "" {
          icon = img.with(width: 10pt)
        } else {
          icon = fa-icon(awesomeIcon)
        }
        box({
          icon
          h(5pt)
          link(linkValue)[#text]
        })
      } else {
        box({
          infoSections.at(k).icon
          h(5pt)
          if infoSections.at(k).linkPrefix != "" {
            link(infoSections.at(k).linkPrefix + v)[#v]
          } else {
            v
          }
        })
      }
      // Adds hBar if it is not the last element
      if n != personalInfo.len() {
        hBar()
      }
      n = n + 1
    }
  }
  let drawHeaderTextSection() = {
    let headerFirstNameStyle(str) = text(
      font: headerFont,
      size: 32pt,
      weight: "light",
      fill: regularColors.darkgray,
      str,
    )
    let headerLastNameStyle(str) = text(
      font: headerFont,
      size: 32pt,
      weight: "bold",
      str,
    )
    let headerInfoStyle(str) = text(size: 10pt, fill: accentColor, str)
    let headerQuoteStyle(str) = text(
      size: 10pt,
      weight: "medium",
      style: "italic",
      fill: accentColor,
      str,
    )

    table(
      columns: 1fr,
      inset: 0pt,
      stroke: none,
      row-gutter: 6mm,
      if nonLatin {
        headerFirstNameStyle(nonLatinName)
      } else [#headerFirstNameStyle(firstName) #h(5pt) #headerLastNameStyle(lastName)],
      headerInfoStyle(drawPersonalInfoSection()),
      headerQuoteStyle(headerQuote),
    )
  }
  let drawHeaderPhotoSection() = {
    set image(height: 3.6cm)
    if showProfilePhoto {
      box(profilePhoto, radius: 50%, clip: true)
    } else {
      v(3.6cm)
    }
  }
  let main(hasPhoto: showProfilePhoto) = {
    let photoSectionWidth = if hasPhoto {
      20%
    } else {
      0%
    }

    // Injection
    inject(
      isInjectAIPromptEnabled: isInjectAIPromptEnabled,
      isInjectKeywordsEnabled: isInjectKeywordsEnabled,
      injectedKeywordsList: injectedKeywordsList,
    )
    // Draw the container
    table(
      columns: (auto, photoSectionWidth),
      inset: 0pt,
      stroke: none,
      column-gutter: 15pt,
      align: headerAlign + horizon,
      drawHeaderTextSection(), drawHeaderPhotoSection(),
    )
  }
  main()
}

/// Insert the footer section of the CV.
///
/// - metadata (array): the metadata read from the TOML file.
/// -> content
#let _cvFooter(metadata) = {
  // Parameters
  let firstName = metadata.personal.first_name
  let lastName = metadata.personal.last_name
  let footerText = metadata.lang.at(metadata.language).cv_footer

  // Styles
  let footerStyle(str) = {
    text(size: 8pt, fill: rgb("#999999"), smallcaps(str))
  }

  place(
    bottom,
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      footerStyle([#firstName #lastName]), footerStyle(footerText),
    ),
  )
}

/// Add the title of a section.
///
/// NOTE: If the language is non-Latin, the title highlight will not be sliced.
///
/// - title (str): The title of the section.
/// - metadata (array): the metadata read from the TOML file.
/// - _awesomeColors (array): (optional) the awesome colors of the CV.
/// -> content
#let cvSection(
  title,
  metadata: metadata,
  _awesomeColors: awesomeColors,
) = {
  let lang = metadata.language
  let nonLatin = isNonLatin(lang)
  let beforeSectionSkip = eval(
    metadata.layout.at("before_section_skip", default: 1pt),
  )
  let highlighted = metadata.layout.section.at("highlighted", default: true)
  let letters = metadata.layout.section.at("highlighted_length", default: 3)
  let accentColor = setAccentColor(_awesomeColors, metadata)
  let highlightText = title.slice(0, letters)
  let normalText = title.slice(letters)
  let sectionTitleStyle(str, color: black) = {
    text(size: 16pt, weight: "bold", fill: color, str)
  }

  v(beforeSectionSkip)
  if nonLatin {
    sectionTitleStyle(title, color: accentColor)
  } else {
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

/// Add an entry to the CV.
///
/// - title (str): The title of the entry.
/// - society (str): The society of the entr (company, university, etc.).
/// - date (str): The date of the entry.
/// - location (str): The location of the entry.
/// - description (array): The description of the entry. It can be a string or an array of strings.
/// - logo (image): The logo of the society. If empty, no logo will be displayed.
/// - tags (array): The tags of the entry.
/// - metadata (array): (optional) the metadata read from the TOML file.
/// - _awesomeColors (array): (optional) the awesome colors of the CV.
/// -> content
#let cvEntry(
  title: "Title",
  society: "Society",
  date: "Date",
  location: "Location",
  description: "Description",
  logo: "",
  tags: (),
  metadata: metadata,
  _awesomeColors: awesomeColors,
) = {
  let accentColor = setAccentColor(_awesomeColors, metadata)
  let beforeEntrySkip = eval(
    metadata.layout.at("before_entry_skip", default: 1pt),
  )
  let beforeEntryDescriptionSkip = eval(
    metadata.layout.at("before_entry_description_skip", default: 1pt),
  )
  let isDisplayingLogo = metadata.layout.entry.display_logo
  let displayEntrySocietyFirst = metadata
    .layout
    .entry
    .display_entry_society_first

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

  let ifSocietyFirst(displayEntrySocietyFirst: displayEntrySocietyFirst, field1, field2) = {
    return if displayEntrySocietyFirst {
      field1
    } else {
      field2
    }
  }
  let ifLogo(img, ifTrue, ifFalse, isDisplayingLogo: isDisplayingLogo) = {
    return if isDisplayingLogo {
      if img == "" {
        ifFalse
      } else {
        ifTrue
      }
    } else {
      ifFalse
    }
  }
  let setLogoContent(logo: logo) = {
    return if logo == "" [] else {
      set image(width: 100%)
      logo
    }
  }

  v(beforeEntrySkip)
  table(
    columns: (ifLogo(logo, 4%, 0%), 1fr),
    inset: 0pt,
    stroke: none,
    align: horizon,
    column-gutter: ifLogo(logo, 4pt, 0pt),
    setLogoContent(),
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      row-gutter: 6pt,
      align: auto,
      entryA1Style(
        ifSocietyFirst(
          society,
          title,
        ),
      ),
      entryA2Style(
        ifSocietyFirst(
          location,
          date,
        ),
      ),

      entryB1Style(
        ifSocietyFirst(
          title,
          society,
        ),
      ),
      entryB2Style(
        ifSocietyFirst(
          date,
          location,
        ),
      ),
    ),
  )
  entryDescriptionStyle(description)
  entryTagListStyle(tags)
}

/// Add a line of skill to the CV.
///
/// A skill is composed of a type (bold at left) and a description (right).
///
/// - type (str): The type of the skill. It is displayed on the left side.
/// - info (content): The information about the skill. It is displayed on the right side. Items can be seperated by `#hbar()`.
/// -> content
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

/// Add a Honor to the CV.
///
/// - date (str): The date of the honor.
/// - title (str): The title of the honor.
/// - issuer (str): The issuer of the honor.
/// - url (str): The URL of the honor.
/// - location (str): The location of the honor.
/// - metadata (array): (optional) The metadata read from the TOML file.
/// - _awesomeColors (array): (optional) The awesome colors of the CV.
/// -> content
#let cvHonor(
  date: "1990",
  title: "Title",
  issuer: "",
  url: "",
  location: "",
  metadata: metadata,
  _awesomeColors: awesomeColors,
) = {
  let accentColor = setAccentColor(_awesomeColors, metadata)

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
    } else if url != "" [
      #honorTitleStyle(link(url)[#title]), #honorIssuerStyle(issuer)
    ] else [
      #honorTitleStyle(title), #honorIssuerStyle(issuer)
    ],
    honorLocationStyle(location),
  )
  v(-6pt)
}

/// Add the publications to the CV by reading a bib file.
///
/// - bib (bibliography): The `bibliography` object with the path to the bib file.
/// - keyList (array): The list of keys to include in the publication list.
/// - refStyle (str): The reference style of the publication list.
/// - refFull (bool): Whether to show the full reference or not.
/// -> content
#let cvPublication(bib: "", keyList: list(), refStyle: "apa", refFull: true) = {
  let publicationStyle(str) = {
    text(str)
  }
  show bibliography: it => publicationStyle(it)
  set bibliography(title: none, style: refStyle, full: refFull)
  bib
}
