// Imports
#import "@preview/brilliant-cv:2.0.1": cv-section, cv-entry, hBar
#let metadata = toml("../metadata.toml")
#let cv-section = cv-section.with(metadata: metadata)
#let cv-entry = cv-entry.with(metadata: metadata)


#cv-section("Education")

#cv-entry(
  title: [Master of Data Science],
  society: [University of California, Los Angeles],
  date: [2018 - 2020],
  location: [USA],
  logo: image("../src/logos/ucla.png"),
  description: list(
    [Thesis: Predicting Customer Churn in Telecommunications Industry using Machine Learning Algorithms and Network Analysis],
    [Course: Big Data Systems and Technologies #hBar() Data Mining and Exploration #hBar() Natural Language Processing],
  ),
)

#cv-entry(
  title: [Bachelors of Science in Computer Science],
  society: [University of California, Los Angeles],
  date: [2018 - 2020],
  location: [USA],
  logo: image("../src/logos/ucla.png"),
  description: list(
    [Thesis: Exploring the Use of Machine Learning Algorithms for Predicting Stock Prices: A Comparative Study of Regression and Time-Series Models],
    [Course: Database Systems #hBar() Computer Networks #hBar() Software Engineering #hBar() Artificial Intelligence],
  ),
)
