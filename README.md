<h1 align="center">
  <img src='https://user-images.githubusercontent.com/77310871/236178717-7ce72cfb-085a-4609-863b-cfceb3d6c9f2.png'>
  <br><br>
  AwesomeCV-Typst
</h1>

<p align="center">
  Relived CV template powered by Typst
</p>

## What is this for?

**AwesomeCV-Typst** is a [**Typst**](https://github.com/typst/typst) template for making **Résume**, **CV** or **Cover Letter** inspired by the famous LaTeX CV template [**Awesome-CV**](https://github.com/posquit0/Awesome-CV). It provides customizations and **multilingual support** beyond the original LaTeX project.

## Preview

| CV | Cover Letter |
|:---:|:---:|
| ![CV](https://user-images.githubusercontent.com/77310871/236178693-bb2d1110-ce2b-40d2-8dbb-8f50d54ecdc1.png)  | ![Cover Letter](https://user-images.githubusercontent.com/77310871/236178700-4502e637-a58f-4b17-a527-0691a1b29218.png) |

| CV (*French, red, no photo*) | Cover Letter (*French, red*) |
|:---:|:---:|
| ![CV](https://user-images.githubusercontent.com/77310871/236298962-ce11e768-a30f-44b8-be64-81525f2b71fb.png)  | ![Cover Letter](https://user-images.githubusercontent.com/77310871/236298505-e2a40791-d797-435d-846a-94555bc8f199.png) |


## Current Issues

> As Typst is still a very young (although very promising and robust to my belief) project, some features are only partially supported on certain platforms. It is hence difficult to predict any anomalies, but you are definitely welcomed to bring a PR, an issue or a discussion!

- **Image cropping**: Typst does not have direct support to crop images using native primitives. Bring your own cropped image for profile photo if needed.
- **Font variants**: There are currently no other ways to handle font families than having them loaded locally. I have included all used fonts in the `src/fonts/` folder.

## Roadmap

> I will gradually develop the template and bring all features that I made possible on the LaTeX platform. These features include:

- **Better Header**: the header should be smarter, with possibilities to adjust profile image position and shape, etc.
- **More customizations**: extra niche subsections and more.
- **Multilingual support**: add non-latin language support (dedicated font families & variants for Chinese or Japanese, for example)

## Usage

**Project Structure**

```
|
|-- modules/          --> sections of your CV, include these at cv.typ
|   |- *.typ
|
|-- modules_*         --> multilingual sections of your CV
|
|-- src/
|   |- fonts/         --> local font files 
|   |- template.typ   --> the template file, import at main files
|   |- metadata.typ   --> your Personal Info variables
|
|-- cv.typ          --> CV file
|-- letter.typ      --> Cover Letter file
```

**Tips**

- Host your submodules in different languages in respective subfoler (`./modules_fr` for instance), and quickly switch your output language by changing the value of `varLanguage` in `metadata.typ`


**Web app**

Upload the `src` folder to the [Typst web app](https://typst.app/), `#import` it in your main typst file and compile it to PDF.

**Local Development**

Clone the repository to your local environment. For compilation, seee further instructions from [**Typst**](https://github.com/typst/typst) page for installing CLI tool. 

For import local font, use the command `typst --font-path ./src/fonts watch *.typ`

## Credit

- [**Typst**](https://github.com/typst/typst) is a newborn, open source and simple typesetting engine that offers a better scripting experience than [**LaTeX**](https://www.latex-project.org/).
- [**Awesome-CV**](https://github.com/posquit0/Awesome-CV) is the original LaTeX CV template from which this project is heavily inspired. Thanks [posquit0](https://github.com/posquit0) for your excellent work!