/*
* Documentation of the functions used in the template, powered by tidy.
*/

#import "@preview/tidy:0.3.0"

#let docs = tidy.parse-module(read("cv.typ"))
#tidy.show-module(docs, omit-private-definitions: true)
