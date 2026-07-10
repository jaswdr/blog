# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Jonathan's personal CV website, served at https://jaswdr.dev/. A single-page Hugo site with no theme: one custom template renders everything from data files.

## Architecture

- **Static Site Generator**: Hugo extended **0.163.3** (pinned in `Dockerfile` / `Makefile`; install via `brew install hugo`)
- **No theme**: the entire page is `layouts/index.html` (inline CSS, no external fonts; theme toggle JS in `assets/js/theme.js`)
- **Content**: all CV content lives in `data/en/`:
  - `author.yaml` - name, contact info, portrait
  - `site.yaml` - description, Open Graph, copyright, CV download link, `dateModified`
  - `sections/about.yaml` - role, company, summary
  - `sections/experiences.yaml` - work history
  - `sections/education.yaml` - degrees, certifications, languages, honors
  - `sections/skills.yaml` - skills by category
- **Portrait**: `assets/images/me.webp`, resized at build time via Hugo image processing
- **Caching**: `nginx.conf` sets long-lived immutable cache for fingerprinted assets; shorter cache for unfingerprinted favicons and HTML

## Common Commands

```bash
make setup         # enable git hooks (once per clone)
make serve         # dev server
make build         # production build to public/
make check-hugo    # verify Hugo version matches Dockerfile
make docker-build  # build the nginx image (also builds the site)
```

## Git hooks

`.githooks/pre-commit` rebuilds the site to a temp dir and validates the
generated `llms.txt`, `cv.txt`, and `cv.json`. Enable once per clone:

```bash
make setup
# or: git config core.hooksPath .githooks
```

## Editing the CV

Change the YAML files under `data/en/` - no template changes needed for new jobs, skills, or contact links. Bump `dateModified` in `site.yaml` when content changes. `public/` is generated; never edit it manually.
