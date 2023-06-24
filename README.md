<h1 align="center">
  <img src='https://github.com/mintyfrankie/mintyfrankie/assets/77310871/64861d2d-971c-47cd-a5e8-5ad8659f2c2b'>
  <br><br>
  AwesomeCV-Typst
</h1>

<p align="center">
  Relived CV template powered by Typst
</p>

## What is this for?

**AwesomeCV-Typst** is a [**Typst**](https://github.com/typst/typst) template for making **Résume**, **CV** or **Cover Letter** inspired by the famous LaTeX CV template [**Awesome-CV**](https://github.com/posquit0/Awesome-CV). It provides customizations and **multilingual support** beyond the original LaTeX project.

## Preview
     
> 
> 💻 [Access to the online Demo](https://typst.app/project/rU2AU43JyRIuhbTN-Rdq66)
>   

| CV | Cover Letter |
|:---:|:---:|
| ![CV](https://github.com/mintyfrankie/mintyfrankie/assets/77310871/94f5fb5c-03d0-4912-b6d6-11ee7d27a9a3)  | ![Cover Letter](https://user-images.githubusercontent.com/77310871/236178700-4502e637-a58f-4b17-a527-0691a1b29218.png) |

| CV (*French, red, no photo*) | Cover Letter (*French, red*) |
|:---:|:---:|
| ![CV](https://user-images.githubusercontent.com/77310871/236298962-ce11e768-a30f-44b8-be64-81525f2b71fb.png)  | ![Cover Letter](https://user-images.githubusercontent.com/77310871/236298505-e2a40791-d797-435d-846a-94555bc8f199.png) |


## Current Issues

> As Typst is still a very young (although very promising and robust to my belief) project, some features are only partially supported on certain platforms. It is hence difficult to predict any anomalies, but you are definitely welcomed to bring a PR, an issue or a discussion!

- **Image cropping**: Typst does not have direct support to crop images using native primitives. Bring your own cropped image for profile photo if needed.
- **Font variants**: There are currently no other ways to handle font families than having them loaded locally. I have included all used fonts in the `src/fonts/` folder.
- **Header icons**: Some icons cannot be properly rendered by Typst-cli in some environments, so not all FontAwesome icons are supported for the moment. See [this Pull Request](https://github.com/mintyfrankie/awesomeCV-Typst-Submodule/pull/1).
- **Publication**: Current version of Typst does not allow full customization on the `#bibliography` function, so the display of publication section might not be optimal. See [this disucssion](https://github.com/mintyfrankie/awesomeCV-Typst/discussions/3).

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
|-- awesomeCV/
|   |- template.typ   --> the template file, imported in the documents
| 
|
|-- src/
|   |- fonts/         --> local font files 
|   |- *.png          --> images used in the documents
|   |- *.bib          --> BibTeX file for Publications section
|
|-- cv.typ          --> CV file
|-- letter.typ      --> Cover Letter file
|-- metadata.typ    --> your Personal Info variables & language settings
```

**Tips**

- Host your submodules in different languages in respective subfoler (`./modules_fr` for instance), and quickly switch your output language by changing the value of `varLanguage` in `metadata.typ`

You can either clone the example repository and modify it locally to have a hands-on experience, or you might want to add this submodule repository and build up your own Typst project.

### Method 1: Clone the [example repository](https://github.com/mintyfrankie/awesomeCV-Typst)

```bash
git clone --recurse-submodules https://github.com/mintyfrankie/awesomeCV-Typst
cd awesomeCV-Typst
typst --font-path ./src/fonts compile cv.typ
``` 

### Method 2: Add the submodule repository to your git project

```bash
cd your/CV/project
git submodule add https://github.com/mintyfrankie/awesomeCV-Typst-Submodule awesomeCV
typst compile cv.typ
```

When the template file is updated:

```bash
git submodule update --remote
```
## Credit

- [**Typst**](https://github.com/typst/typst) is a newborn, open source and simple typesetting engine that offers a better scripting experience than [**LaTeX**](https://www.latex-project.org/).
- [**Awesome-CV**](https://github.com/posquit0/Awesome-CV) is the original LaTeX CV template from which this project is heavily inspired. Thanks [posquit0](https://github.com/posquit0) for your excellent work!
