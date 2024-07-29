// Imports
#import "@preview/brilliant-cv:2.0.1": cv-section, cv-skill, hBar
#let metadata = toml("../metadata.toml")
#let cv-section = cv-section.with(metadata: metadata)


#cv-section("Compétences")

#cv-skill(
  type: [Langues],
  info: [Anglais #hBar() Français #hBar() Chinois],
)

#cv-skill(
  type: [Tech Stack],
  info: [Tableau #hBar() Python (Pandas/Numpy) #hBar() PostgreSQL],
)

#cv-skill(
  type: [Centres d'intérêt],
  info: [Natation #hBar() Cuisine #hBar() Lecture],
)
