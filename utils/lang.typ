/*
A module containing functions for multi-language support.
*/

#let is-non-latin(lang) = {
  let non-latin-language-code = ("zh", "ja", "ko", "ru")
  return non-latin-language-code.contains(lang)
}
