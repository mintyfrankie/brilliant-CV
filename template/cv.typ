// Imports
#import "@preview/brilliant-CV:2.0.0": cv, importModule
#let metadata = toml("./metadata.toml")
#let importModules(module_names, lang: metadata.language) = {
  for module in module_names {
    include {
      "modules_" + lang + "/" + module + ".typ"
    }
  }
}


#show: cv.with(metadata)
#importModules((
  "education",
  "professional",
  "projects",
  "certificates",
  "publications",
  "skills",
))
