/*
A module containing functions for multi-language support.
*/

#let isNonLatin(lang) = {
  let nonLatinLanguageCode = ("zh", "ja", "ko", "ru")
  return nonLatinLanguageCode.contains(lang)
}
