#import "src/template.typ": *
#show: layout

#cvHeader()
  #autoImport("education")
  #autoImport("professional")
  #autoImport("projects")
  #autoImport("skills")
#cvFooter()
