#import "@preview/fontawesome:0.2.1": *
#import "./injection.typ": inject
#import "./misc.typ": hBar

#let cvHeader(metadata, headerFont, regularColors, accentColor) = {
  // Parameters
  let hasPhoto = metadata.layout.header.display_profile_photo
  let align = eval(metadata.layout.header.header_align)
  let if_inject_ai_prompt = metadata.inject.inject_ai_prompt
  let if_inject_keywords = metadata.inject.inject_keywords
  let keywords_list = metadata.inject.injected_keywords_list
  let personalInfo = metadata.personal.info
  let firstName = metadata.personal.first_name
  let lastName = metadata.personal.last_name
  let headerQuote = metadata.lang.at(metadata.language).header_quote
  let displayProfilePhoto = metadata.layout.header.display_profile_photo
  let profilePhotoPath = metadata.layout.header.profile_photo_path

  // Injection
  inject(
    if_inject_ai_prompt: if_inject_ai_prompt,
    if_inject_keywords: if_inject_keywords,
    keywords_list: keywords_list,
  )

  // Styles
  let headerFirstNameStyle(str) = {
    text(
      font: headerFont,
      size: 32pt,
      weight: "light",
      fill: regularColors.darkgray,
      str,
    )
  }
  let headerLastNameStyle(str) = {
    text(font: headerFont, size: 32pt, weight: "bold", str)
  }
  let headerInfoStyle(str) = {
    text(size: 10pt, fill: accentColor, str)
  }
  let headerQuoteStyle(str) = {
    text(size: 10pt, weight: "medium", style: "italic", fill: accentColor, str)
  }

  // Components
  let makeHeaderInfo() = {
    let personalInfoIcons = (
      phone: fa-phone(),
      email: fa-envelope(),
      linkedin: fa-linkedin(),
      homepage: fa-pager(),
      github: fa-square-github(),
      gitlab: fa-gitlab(),
      orcid: fa-orcid(),
      researchgate: fa-researchgate(),
      location: fa-location-dot(),
      extraInfo: "",
    )
    let n = 1
    for (k, v) in personalInfo {
      // A dirty trick to add linebreaks with "linebreak" as key in personalInfo
      if k == "linebreak" {
        n = 0
        linebreak()
        continue
      }
      if k.contains("custom") {
        // example value (icon: fa-graduation-cap(), text: "PhD", link: "https://www.example.com")
        let icon = v.at("icon", default: "")
        let text = v.at("text", default: "")
        let link_value = v.at("link", default: "")
        box({
          icon
          h(5pt)
          link(link_value)[#text]
        })
      } else if v != "" {
        box({
          // Adds icons
          personalInfoIcons.at(k) + h(5pt)
          // Adds hyperlinks
          if k == "email" {
            link("mailto:" + v)[#v]
          } else if k == "linkedin" {
            link("https://www.linkedin.com/in/" + v)[#v]
          } else if k == "github" {
            link("https://github.com/" + v)[#v]
          } else if k == "gitlab" {
            link("https://gitlab.com/" + v)[#v]
          } else if k == "homepage" {
            link("https://" + v)[#v]
          } else if k == "orcid" {
            link("https://orcid.org/" + v)[#v]
          } else if k == "researchgate" {
            link("https://www.researchgate.net/profile/" + v)[#v]
          } else {
            v
          }
        })
      }
      // Adds hBar
      if n != personalInfo.len() {
        hBar()
      }
      n = n + 1
    }
  }

  let makeHeaderNameSection() = table(
    columns: 1fr,
    inset: 0pt,
    stroke: none,
    row-gutter: 6mm,
    [#headerFirstNameStyle(firstName) #h(5pt) #headerLastNameStyle(lastName)],
    [#headerInfoStyle(makeHeaderInfo())],
    [#headerQuoteStyle(headerQuote)],
  )

  let makeHeaderPhotoSection() = {
    if displayProfilePhoto {
      box(
        image(profilePhotoPath, height: 3.6cm),
        radius: 50%,
        clip: true,
      )
    } else {
      v(3.6cm)
    }
  }

  let makeHeader(leftComp, rightComp, columns, align) = table(
    columns: columns,
    inset: 0pt,
    stroke: none,
    column-gutter: 15pt,
    align: align + horizon,
    {
      leftComp
    },
    {
      rightComp
    },
  )

  if hasPhoto {
    makeHeader(
      makeHeaderNameSection(),
      makeHeaderPhotoSection(),
      (auto, 20%),
      align,
    )
  } else {
    makeHeader(
      makeHeaderNameSection(),
      makeHeaderPhotoSection(),
      (auto, 0%),
      align,
    )
  }
}

#let cvFooter(metadata) = {
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