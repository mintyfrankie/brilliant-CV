watch-cv:
  typst --font-path ./src/fonts/ watch ./cv.typ ./output/CV.pdf

watch-letter:
  typst --font-path ./src/fonts/ watch ./letter.typ ./output/Letter.pdf

compile-cv:
  typst --font-path ./src/fonts/ compile ./cv.typ ./output/CV.pdf

compile-letter: 
  typst --font-path ./src/fonts/ compile ./letter.typ ./output/Letter.pdf