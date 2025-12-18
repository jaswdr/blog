---
title: "Docker Hardened Images Are Free"
subtitle: "Docker just made enterprise-grade container security available to every developer"
date: 2025-12-18T10:04:57Z
lastmod: 2025-12-18T10:04:57Z
draft: false
author: "Jonathan Schweder"
description: "Docker's Hardened Images are now free for everyone. Learn what they are, how to migrate from standard images, and why they're essential for modern container security."

tags: ["docker", "security", "containers", "devops", "supply-chain"]
categories: ["Technology", "Security"]
series: []

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

Docker just released container hardened images for free for everyone. On December 17, 2025, they announced that their Hardened Images, previously an enterprise-only feature—are are now completely free and open source for all developers. Docker Hardened Images (DHI) are secure, minimal container images built for production. Think of them as Docker Official Images with increased security. Key features include near-zero CVEs, up to 95% smaller images, built on familiar Alpine and Debian foundations, complete transparency with SBOMs and SLSA provenance, and Apache 2.0 licensing. This is extremely relevant to every startup, open source project, and solo developer out there by dramatically reducing attack surfaces, cutting cloud costs, and eliminating constant CVE firefighting. The catalog covers everything you need: language runtimes (Python, Node.js, Go), databases (PostgreSQL, MongoDB, Redis), infrastructure tools (Nginx, Traefik), observability stack (Prometheus, Grafana), and security tools (Vault, Trivy).

Migrating to Docker Hardened Images is surprisingly easy since they build on familiar Alpine and Debian foundations. For a Node.js application, you simply change the `FROM` line:

**Before:**

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

**After:**

```dockerfile
FROM dhi.io/node:20-alpine13
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

That's it, just update the base image and you automatically get a smaller attack surface, non-root user configuration, minimal packages with vetted versions, and built-in security scanning. For larger migrations, browse the catalog at [dhi.io](https://dhi.io) to find hardened equivalents for your current images, update your FROM statements, and test. Most applications work without any changes. Start with development environments first, then update your CI/CD pipelines once you've verified everything works. The question isn't whether you should use Docker Hardened Images—it's why you wouldn't.
