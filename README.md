# Jonathan Schweder — Personal CV

Single-page Hugo site for [jaswdr.dev](https://jaswdr.dev/). No theme: one custom template renders everything from YAML data files.

## Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) **0.163.3** (same version as the Docker build)
- [Docker](https://www.docker.com/get-started/) (optional, for production image)
- Make

## Setup

```bash
git clone https://github.com/jaswdr/website
cd website
make setup   # enables git hooks (validates llms.txt / cv.txt / cv.json on commit)
```

## Local development

```bash
make serve         # http://localhost:1313 with live reload
make build         # production build to public/
make check-hugo    # verify local Hugo matches the pinned version
make docker-build  # build the nginx image (also builds the site)
make docker-run    # serve the image on http://localhost:8080
```

## Editing the CV

Change the YAML under `data/en/` — no template changes needed for new jobs, skills, or contact links:

| File | Contents |
|------|----------|
| `data/en/author.yaml` | Name, contact links, portrait path |
| `data/en/site.yaml` | Description, Open Graph, copyright, CV PDF URL, `dateModified` |
| `data/en/sections/about.yaml` | Role, company, summary |
| `data/en/sections/experiences.yaml` | Work history |
| `data/en/sections/education.yaml` | Degrees, certifications, languages, honors |
| `data/en/sections/skills.yaml` | Skills by category |

`public/` is generated; never edit it manually.

## Machine-readable outputs

The home page also builds:

- `/llms.txt` — LLM-oriented summary
- `/cv.txt` — plain-text CV
- `/cv.json` — [JSON Resume](https://jsonresume.org/) schema

## Project structure

- `layouts/` — HTML, 404, and machine-readable templates
- `data/en/` — all CV content
- `assets/` — portrait and OG base image (Hugo-processed)
- `static/` — favicons, `robots.txt`
- `archive/` — old site content kept for reference (not rendered)
