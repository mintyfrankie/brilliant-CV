#import "brilliant-CV/template.typ": *
#import "brilliant-CV/utils/lang.typ": autoImport
#show: cv.with(metadata_path: "../metadata.toml")

#cvHeader(hasPhoto: true, align: left)
#autoImport("education")
#autoImport("professional")
#autoImport("projects")
#autoImport("certificates")
#autoImport("publications")
#autoImport("skills")
#cvFooter()
