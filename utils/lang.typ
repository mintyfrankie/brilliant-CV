/*
A module containing functions for multi-language support.
*/

#let isNonLatin(lang) = {
  let non-latinLanguageCode = ("zh", "ja", "ko", "ru")
  return non-latinLanguageCode.contains(lang)
}
