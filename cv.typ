#import "brilliant-CV/template.typ": *
#show: cv.with(
  metadata_path: "../metadata.toml",
  include_modules: (
    "education",
    "professional",
    "projects",
    "certificates",
    "publications",
    "skills",
  ),
)
