/*
* Documentation of the functions used in the template, powered by tidy.
*/

#import "@preview/tidy:0.3.0"
#import "./docs-template.typ": *
#let version = toml("/typst.toml").package.version

#show: template.with(title: "brilliant-CV", authors: ("mintyfrankie"))

= brilliant-CV
= Documentation

#h(10pt)

#rect[
  _Build Date: #datetime.today().display()_

  _Version: #version _
]

#h(10pt)


== 1. Introduction

Brilliant CV is a Typst template for making Résume, CV or Cover Letter inspired by the famous LaTeX CV template Awesome-CV.

== 2. Setup

== 3. Migration from `v1` to `v2`

#pagebreak()
== 4. Functions
#linebreak()

#let docs = tidy.parse-module(read("/cv.typ"))
#tidy.show-module(
  docs,
  show-outline: false,
  omit-private-definitions: true,
  omit-private-parameters: true,
)
