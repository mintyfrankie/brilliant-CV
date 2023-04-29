
#let accentColor = rgb("#0395DE")
#let headerFont = "Roboto"
#let bodyFont = "Source Sans Pro"

#let headerInfoStyle(str) = {text(
  font: (bodyFont, "Font Awesome 6 Brands", "Font Awesome 6 Free"),
  size: 10pt,
  fill: accentColor,
  str
)}

#let personalInfo = (
  phone: "+33 6 12 34 56 78",
  email: "john.doe@me.org",
  linkedin: "johndoe",
  extraInfo: "",
)

#let personalInfoIcons = (
    phone: [\u{f2c1}],
    email: [\u{f0e0}],
    linkedin: [\u{f08c}],
    extraInfo: "",
  )

#let makeHeaderInfo() = {
  let n = 1
  for (k, v) in personalInfo {
    if v != "" {
      if n != 1 {
        h(5pt) + "|" + h(5pt)
      }
      personalInfoIcons.at(k) + h(5pt) + v 
    }
    n = n + 1
  }
}

#headerInfoStyle(makeHeaderInfo())