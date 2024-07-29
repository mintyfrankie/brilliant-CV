/*
* Functions for the CV template
*/

#import "@preview/fontawesome:0.2.1": *
#import "./utils/injection.typ": inject
#import "./utils/styles.typ": hBar, latin-font-list, latinheader-font, awesome-colors, regular-colors, set-accent-color
#import "./utils/lang.typ": is-non-latin

/// Insert the header section of the CV.
///
/// - metadata (array): the metadata read from the TOML file.
/// - header-font (array): the font of the header.
/// - regular-colors (array): the regular colors of the CV.
/// - awesome-colors (array): the awesome colors of the CV.
/// -> content
#let cv-header(
  metadata,
  profile-photo,
  header-font,
  regular-colors,
  awesome-colors,
) = {
  // Parameters
  let show-profile-photo = metadata.layout.header.at(
    "display_profile_photo",
    default: true,
  )
  let header-align = eval(
    metadata.layout.header.at("header_align", default: "left"),
  )
  let is-inject-ai-prompt-enabled = metadata.inject.at(
    "inject_ai_prompt",
    default: false,
  )
  let is-inject-keywords-enabled = metadata.inject.at(
    "inject_keywords",
    default: false,
  )
  let injected-keywords-list = metadata.inject.at(
    "injected_keywords_list",
    default: (),
  )
  let personal-info = metadata.personal.info
  let first-name = metadata.personal.first_name
  let last-name = metadata.personal.last_name
  let header-quote = metadata.lang.at(metadata.language).header_quote
  let accent-color = set-accent-color(awesome-colors, metadata)

  // Non Latin Logic
  let non-latin-name = ""
  let non-latin = is-non-latin(metadata.language)
  if non-latin {
    non-latin-name = metadata.lang.non_latin.name
  }

  // Components
  let draw-personal-info-section(personal-info: personal-info) = {
    let info-sections = (
      phone: (icon: fa-phone(), link-refix: "tel:"),
      email: (icon: fa-envelope(), link-refix: "mailto:"),
      linkedin: (
        icon: fa-linkedin(),
        link-refix: "https://www.linkedin.com/in/",
      ),
      homepage: (icon: fa-pager(), link-refix: "https://"),
      github: (icon: fa-square-github(), link-refix: "https://github.com/"),
      gitlab: (icon: fa-gitlab(), link-refix: "https://gitlab.com/"),
      orcid: (icon: fa-orcid(), link-refix: "https://orcid.org/"),
      researchgate: (
        icon: fa-researchgate(),
        link-refix: "https://www.researchgate.net/profile/",
      ),
      location: (icon: fa-location-dot(), link-refix: ""),
      extra-info: (icon: "", link-refix: ""),
    )
    // Loop through personal-info to draw each info section
    let n = 1
    for (k, v) in personal-info {
      // If the key contains "custom", it means it is a custom section
      if k.contains("custom") {
        let img = v.at("image", default: "")
        let awesome-icon = v.at("awesome-icon", default: "")
        let text = v.at("text", default: "")
        let link-value = v.at("link", default: "")
        let icon = ""
        if img != "" {
          icon = img.with(width: 10pt)
        } else {
          icon = fa-icon(awesome-icon)
        }
        box({
          icon
          h(5pt)
          link(link-value)[#text]
        })
      } else {
        box({
          info-sections.at(k).icon
          h(5pt)
          if info-sections.at(k).link-refix != "" {
            link(info-sections.at(k).link-refix + v)[#v]
          } else {
            v
          }
        })
      }
      // Adds hBar if it is not the last element
      if n != personal-info.len() {
        hBar()
      }
      n = n + 1
    }
  }
  let draw-header-text-section() = {
    let header-first-name-style(str) = text(
      font: header-font,
      size: 32pt,
      weight: "light",
      fill: regular-colors.darkgray,
      str,
    )
    let header-last-name-style(str) = text(
      font: header-font,
      size: 32pt,
      weight: "bold",
      str,
    )
    let header-info-style(str) = text(size: 10pt, fill: accent-color, str)
    let header-quote-style(str) = text(
      size: 10pt,
      weight: "medium",
      style: "italic",
      fill: accent-color,
      str,
    )

    table(
      columns: 1fr,
      inset: 0pt,
      stroke: none,
      row-gutter: 6mm,
      if non-latin {
        header-first-name-style(non-latin-name)
      } else [#header-first-name-style(first-name) #h(5pt) #header-last-name-style(last-name)],
      header-info-style(draw-personal-info-section()),
      header-quote-style(header-quote),
    )
  }
  let draw-header-photo-section() = {
    set image(height: 3.6cm)
    if show-profile-photo {
      box(profile-photo, radius: 50%, clip: true)
    } else {
      v(3.6cm)
    }
  }
  let main(hasPhoto: show-profile-photo) = {
    let photoSectionWidth = if hasPhoto {
      20%
    } else {
      0%
    }

    // Injection
    inject(
      is-inject-ai-prompt-enabled: is-inject-ai-prompt-enabled,
      is-inject-keywords-enabled: is-inject-keywords-enabled,
      injected-keywords-list: injected-keywords-list,
    )
    // Draw the container
    table(
      columns: (auto, photoSectionWidth),
      inset: 0pt,
      stroke: none,
      column-gutter: 15pt,
      align: header-align + horizon,
      draw-header-text-section(), draw-header-photo-section(),
    )
  }
  main()
}

/// Insert the footer section of the CV.
///
/// - metadata (array): the metadata read from the TOML file.
/// -> content
#let cv-footer(metadata) = {
  // Parameters
  let first-name = metadata.personal.first_name
  let last-name = metadata.personal.last_name
  let footer-text = metadata.lang.at(metadata.language).cv_footer

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
      footer-style([#first-name #last-name]), footer-style(footer-text),
    ),
  )
}

/// Add the title of a section.
///
/// NOTE: If the language is non-Latin, the title highlight will not be sliced.
///
/// - title (str): The title of the section.
/// - metadata (array): the metadata read from the TOML file.
/// - awesome-colors (array): (optional) the awesome colors of the CV.
/// -> content
#let cv-section(
  title,
  metadata: metadata,
  awesome-colors: awesome-colors,
) = {
  let lang = metadata.language
  let non-latin = is-non-latin(lang)
  let before-section-skip = eval(
    metadata.layout.at("before_section_skip", default: 1pt),
  )
  let highlighted = metadata.layout.section.at("highlighted", default: true)
  let letters = metadata.layout.section.at("highlighted_length", default: 3)
  let accent-color = set-accent-color(awesome-colors, metadata)
  let highligh-text = title.slice(0, letters)
  let normalText = title.slice(letters)
  let section-title-style(str, color: black) = {
    text(size: 16pt, weight: "bold", fill: color, str)
  }

  v(before-section-skip)
  if non-latin {
    section-title-style(title, color: accent-color)
  } else {
    if highlighted {
      section-title-style(highligh-text, color: accent-color)
      section-title-style(normalText, color: black)
    } else {
      section-title-style(title, color: black)
    }
  }
  h(2pt)
  box(width: 1fr, line(stroke: 0.9pt, length: 100%))
}

/// Add an entry to the CV.
/// 
///
/// - title (str): The title of the entry.
/// - society (str): The society of the entr (company, university, etc.).
/// - date (str): The date of the entry.
/// - location (str): The location of the entry.
/// - description (str, array, content): The description of the entry. It can be a string or an array of strings.
/// - logo (image): The logo of the society. If empty, no logo will be displayed.
/// - tags (array): The tags of the entry.
/// - metadata (array): (optional) the metadata read from the TOML file.
/// - awesome-colors (array): (optional) the awesome colors of the CV.
/// -> content
#let cv-entry(
  title: "Title",
  society: "Society",
  date: "Date",
  location: "Location",
  description: "Description",
  logo: "",
  tags: ("Tag1", "Tag2"),
  metadata: metadata,
  awesome-colors: awesome-colors,
) = {
  let accent-color = set-accent-color(awesome-colors, metadata)
  let before-entry-skip = eval(
    metadata.layout.at("before_entry_skip", default: 1pt),
  )
  let before-entry-description-skip = eval(
    metadata.layout.at("before_entry_description_skip", default: 1pt),
  )
  let is-displaying-logo = metadata.layout.entry.display_logo
  let display-entry-society-first = metadata
    .layout
    .entry
    .display_entry_society_first

  let entry-a1-style(str) = {
    text(size: 10pt, weight: "bold", str)
  }
  let entry-a2-style(str) = {
    align(
      right,
      text(weight: "medium", fill: accent-color, style: "oblique", str),
    )
  }
  let entry-b1-style(str) = {
    text(size: 8pt, fill: accent-color, weight: "medium", smallcaps(str))
  }
  let entry-b2-style(str) = {
    align(
      right,
      text(size: 8pt, weight: "medium", fill: gray, style: "oblique", str),
    )
  }
  let entry-description-style(str) = {
    text(
      fill: regular-colors.lightgray,
      {
        v(before-entry-description-skip)
        str
      },
    )
  }
  let entry-tag-style(str) = {
    align(center, text(size: 8pt, weight: "regular", str))
  }
  let entry-tag-list-style(tags) = {
    for tag in tags {
      box(
        inset: (x: 0.25em),
        outset: (y: 0.25em),
        fill: regular-colors.subtlegray,
        radius: 3pt,
        entry-tag-style(tag),
      )
      h(5pt)
    }
  }

  let if-society-first(display-entry-society-first: display-entry-society-first, field1, field2) = {
    return if display-entry-society-first {
      field1
    } else {
      field2
    }
  }
  let if-logo(img, if-true, if-false, is-displaying-logo: is-displaying-logo) = {
    return if is-displaying-logo {
      if img == "" {
        if-false
      } else {
        if-true
      }
    } else {
      if-false
    }
  }
  let set-logo-content(logo: logo) = {
    return if logo == "" [] else {
      set image(width: 100%)
      logo
    }
  }

  v(before-entry-skip)
  table(
    columns: (if-logo(logo, 4%, 0%), 1fr),
    inset: 0pt,
    stroke: none,
    align: horizon,
    column-gutter: if-logo(logo, 4pt, 0pt),
    set-logo-content(),
    table(
      columns: (1fr, auto),
      inset: 0pt,
      stroke: none,
      row-gutter: 6pt,
      align: auto,
      entry-a1-style(
        if-society-first(
          society,
          title,
        ),
      ),
      entry-a2-style(
        if-society-first(
          location,
          date,
        ),
      ),

      entry-b1-style(
        if-society-first(
          title,
          society,
        ),
      ),
      entry-b2-style(
        if-society-first(
          date,
          location,
        ),
      ),
    ),
  )
  entry-description-style(description)
  entry-tag-list-style(tags)
}

/// Add a line of skill to the CV.
///
/// A skill is composed of a type (bold at left) and a description (right).
///
/// - type (str): The type of the skill. It is displayed on the left side.
/// - info (content): The information about the skill. It is displayed on the right side. Items can be seperated by `#hbar()`.
/// -> content
#let cv-skill(type: "Type", info: "Info") = {
  let skill-type-style(str) = {
    align(right, text(size: 10pt, weight: "bold", str))
  }
  let skill-info-style(str) = {
    text(str)
  }

  table(
    columns: (16%, 1fr),
    inset: 0pt,
    column-gutter: 10pt,
    stroke: none,
    skill-type-style(type), skill-info-style(info),
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
/// - awesome-colors (array): (optional) The awesome colors of the CV.
/// -> content
#let cv-honor(
  date: "1990",
  title: "Title",
  issuer: "",
  url: "",
  location: "",
  metadata: metadata,
  awesome-colors: awesome-colors,
) = {
  let accent-color = set-accent-color(awesome-colors, metadata)

  let honor-date-style(str) = {
    align(right, text(str))
  }
  let honor-title-style(str) = {
    text(weight: "bold", str)
  }
  let honor-issuer-style(str) = {
    text(str)
  }
  let honor-location-style(str) = {
    align(
      right,
      text(weight: "medium", fill: accent-color, style: "oblique", str),
    )
  }

  table(
    columns: (16%, 1fr, 15%),
    inset: 0pt,
    column-gutter: 10pt,
    align: horizon,
    stroke: none,
    honor-date-style(date),
    if issuer == "" {
      honor-title-style(title)
    } else if url != "" [
      #honor-title-style(link(url)[#title]), #honor-issuer-style(issuer)
    ] else [
      #honor-title-style(title), #honor-issuer-style(issuer)
    ],
    honor-location-style(location),
  )
  v(-6pt)
}

/// Add the publications to the CV by reading a bib file.
///
/// - bib (bibliography): The `bibliography` object with the path to the bib file.
/// - keyList (array): The list of keys to include in the publication list.
/// - ref-style (str): The reference style of the publication list.
/// - ref-full (bool): Whether to show the full reference or not.
/// -> content
#let cv-publication(bib: "", keyList: list(), ref-style: "apa", ref-full: true) = {
  let publication-style(str) = {
    text(str)
  }
  show bibliography: it => publication-style(it)
  set bibliography(title: none, style: ref-style, full: ref-full)
  bib
}
