# Jonathan Schweder - Personal Website

Personal website built with Hugo and the [DoIt](https://github.com/HEIGE-PULT/DoIt) theme.

## Overview
This repository contains the source code for [jaswdr.dev](https://jaswdr.dev/).

## Local Development

### Prerequisites
- [Hugo Extended](https://gohugo.io/installation/)
- [Docker](https://docs.docker.com/get-docker/)
- [Make](https://www.gnu.org/software/make/)

### Running Locally
```bash
# Clone the repository
git clone --recursive https://github.com/jaswdr/website
cd website

# Run development server
make serve
```

## Deployment
The site is built and deployed as a set of static files.

```bash
make build
```

## Project Structure
- `content/`: Pages and sections.
- `layouts/`: Custom Hugo templates.
- `static/`: Static assets (images, fonts).
- `themes/`: Hugo theme submodules.
