// Imports
#import "@preview/brilliant-cv:2.0.1": cv-section, cv-skill, hBar
#let metadata = toml("../metadata.toml")
#let cv-section = cv-section.with(metadata: metadata)


#cv-section("Skills")

#cv-skill(
  type: [Languages],
  info: [English #hBar() French #hBar() Chinese],
)

#cv-skill(
  type: [Tech Stack],
  info: [Tableau #hBar() Python (Pandas/Numpy) #hBar() PostgreSQL],
)

#cv-skill(
  type: [Personal Interests],
  info: [Swimming #hBar() Cooking #hBar() Reading],
)
