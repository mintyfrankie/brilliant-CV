/*
A module containing functions for multi-language support.
*/

#let is-non-latin(lang) = {
  let non-latinLanguageCode = ("zh", "ja", "ko", "ru")
  return non-latinLanguageCode.contains(lang)
}
