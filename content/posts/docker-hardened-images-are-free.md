---
title: "Docker Hardened Images Are Free"
subtitle: "Docker just made enterprise-grade container security available to every developer"
date: 2025-12-18T10:04:57Z
lastmod: 2025-12-18T10:04:57Z
draft: false
author: "Jonathan Schweder"
description: "Docker's Hardened Images are now free for everyone. Learn what they are, how to migrate from standard images, and why they're essential for modern container security."

tags: ["docker", "security", "containers", "devops", "supply-chain"]
categories: ["Containers", "Security"]
series: []

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: "/posts/docker-hardened-images-are-free/featured.jpg"
featuredImagePreview: "/posts/docker-hardened-images-are-free/featured.jpg"

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

Docker just made container security free for everyone. On December 17, 2025, they announced that their Hardened Images, previously an enterprise-only feature, are now completely free and open source for all developers. Docker Hardened Images (DHI) are secure, minimal container images built for production.

Think of them as Docker Official Images with enterprise-grade security hardening. Key features include near-zero CVEs, up to 95% smaller images, built on familiar Alpine and Debian foundations, complete transparency with SBOMs and SLSA provenance, and Apache 2.0 licensing. This matters for every startup, open source project, and solo developer by dramatically reducing attack surfaces, cutting cloud costs, and eliminating constant CVE firefighting. The catalog covers everything: language runtimes (Python, Node.js, Go), databases (PostgreSQL, MongoDB, Redis), infrastructure tools (Nginx, Traefik), observability stack (Prometheus, Grafana), and security tools (Vault, Trivy).

Migrating to Docker Hardened Images is surprisingly easy since they build on familiar Alpine and Debian foundations. For a Node.js application, you simply change the `FROM` line:

**Before:**

```dockerfile
FROM node:25
WORKDIR /app
COPY package*.json ./
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

**After:**

```dockerfile
FROM dhi.io/node:25-debian12
WORKDIR /app
COPY package*.json ./
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

That's it. Just update the base image and you automatically get a smaller attack surface, non-root user configuration, minimal packages with vetted versions, and built-in security scanning. For larger migrations, browse the catalog at [dhi.io](https://dhi.io) to find hardened equivalents for your current images, update your FROM statements, and test. Most applications work without any changes. Start with development environments first, then update your CI/CD pipelines once you've verified everything works. The question isn't whether you should use Docker Hardened Images. It's why you wouldn't.
