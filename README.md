<h1 align="center">
  <img src='https://user-images.githubusercontent.com/77310871/236178717-7ce72cfb-085a-4609-863b-cfceb3d6c9f2.png'>
  <br><br>
  AwesomeCV-Typst
</h1>

<p align="center">
  Relived CV template powered by Typst
</p>

## What is this for?

**AwesomeCV-Typst** is a [**Typst**](https://github.com/typst/typst) template for making **Résume**, **CV** or **Cover Letter** inspired by the famous LaTeX CV template [**Awesome-CV**](https://github.com/posquit0/Awesome-CV). 

## Preview

| CV | Cover Letter |
|:---:|:---:|
| ![CV](https://user-images.githubusercontent.com/77310871/236178693-bb2d1110-ce2b-40d2-8dbb-8f50d54ecdc1.png)  | ![Cover Letter](https://user-images.githubusercontent.com/77310871/236178700-4502e637-a58f-4b17-a527-0691a1b29218.png) |


## Current Issues

> As Typst is still a very young (although very promising and robust to my belief) project, some features are only partially supported on certain platforms. It is hence difficult to predict any anomalies, but you are definitely welcomed to bring a PR, an issue or a discussion!

- **Image cropping**: Typst does not have direct support to crop images using native primitives. Bring your own cropped image for profile photo if needed.
- **Font variants**: There are currently no other ways to handle font families than having them loaded locally. I have included all used fonts in the `src/fonts/` folder.

## Roadmap

> I will gradually develop the template and bring all features that I made possible on the LaTeX platform. These features include:

- **Better Header**: the header should be smarter, with possibilities to adjust profile image position and shape, etc.
- **More customizations**: extra niche subsections and more.
- **Multilingual support**: manage your CV **content** in different language versions (three languages, in my case) in a single project, while without touching on the format. 
- **Cover Letter**: write your cover letter using the same aesthetic design.

## Usage

**Project Structure**

```
|
|-- modules/          --> sections of your CV, include these at main.typ
|   |- *.typ
|
|-- src/
|   |- template.typ   --> the template file, import at main.typ
|   |- metadata.typ   --> your Personal Info variables
|
|-- main.typ          --> main typst file
```

**Web app**

Upload the `src` folder to the [Typst web app](https://typst.app/), `#import` it in your main typst file and compile it to PDF.

**Local Development**

Clone the repository to your local environment. For compilation, seee further instructions from [**Typst**](https://github.com/typst/typst) page for installing CLI tool. 

> **Notice**: You might need to find a workaround to deal with the font issues, until Typst provide an official support for importing custom fonts.


## Credit

- [**Typst**](https://github.com/typst/typst) is a newborn, open source and simple typesetting engine that offers a better scripting experience than [**LaTeX**](https://www.latex-project.org/).
- [**Awesome-CV**](https://github.com/posquit0/Awesome-CV) is the original LaTeX CV template from which this project is heavily inspired. Thanks [posquit0](https://github.com/posquit0) for your excellent work!