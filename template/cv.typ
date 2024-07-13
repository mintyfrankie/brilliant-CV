#import "@preview/brilliant-CV:2.0.0": *
#let metadata = toml("./metadata.toml")

#show: cv.with(
  metadata,
  include_modules: (
    "education",
    "professional",
    "projects",
    "certificates",
    "publications",
    "skills",
  ),
)
