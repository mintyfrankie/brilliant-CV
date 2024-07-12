#import "brilliant-CV/template.typ": *
#import "brilliant-CV/utils/lang.typ": autoImport
#show: layout

#cvHeader(hasPhoto: true, align: left)
#autoImport("education")
#autoImport("professional")
#autoImport("projects")
#autoImport("certificates")
#autoImport("publications")
#autoImport("skills")
#cvFooter()
