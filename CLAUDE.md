# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Jonathan's personal CV website, served at https://jaswdr.dev/. A single-page Hugo site with no theme: one custom template renders everything from data files.

## Architecture

- **Static Site Generator**: Hugo extended (install via `brew install hugo`)
- **No theme**: the entire page is `layouts/index.html` (inline CSS, no external fonts, no JS besides PostHog)
- **Content**: all CV content lives in `data/en/`:
  - `author.yaml` - name, contact info, portrait
  - `site.yaml` - description, Open Graph, copyright, CV download link
  - `sections/about.yaml` - role, company, summary
  - `sections/experiences.yaml` - work history
  - `sections/skills.yaml` - skill chips
- **Portrait**: `assets/images/me.webp`, resized at build time via Hugo image processing
- **Analytics**: PostHog via `layouts/partials/posthog.html`, proxied through `/ingest` (see `nginx.conf`) to bypass ad-blockers; disabled on the dev server
- **Caching**: `nginx.conf` sets long-lived immutable cache headers for hashed assets, short for HTML
- **Old content**: `content/old/` keeps the previous site's markdown for reference; it is not rendered

## Common Commands

```bash
make serve         # dev server
make build         # production build to public/
make docker-build  # build the nginx image (also builds the site)
```

## Editing the CV

Change the YAML files under `data/en/` - no template changes needed for new jobs, skills, or contact links. `public/` is generated; never edit it manually.
