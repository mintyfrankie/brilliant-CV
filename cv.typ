#import "brilliant-CV/template.typ": *
#import "brilliant-CV/utils/lang.typ": autoImport
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
