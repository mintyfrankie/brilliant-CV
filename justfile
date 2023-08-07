watch-cv:
  typst watch ./cv.typ ./output/CV.pdf --font-path ./src/fonts/ 

watch-letter:
  typst watch ./letter.typ ./output/Letter.pdf --font-path ./src/fonts/

compile-cv:
  typst compile ./cv.typ ./output/CV.pdf --font-path ./src/fonts/

compile-letter: 
  typst compile ./letter.typ ./output/Letter.pdf  --font-path ./src/fonts/ 