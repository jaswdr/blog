# Build stage
FROM debian:stable-slim AS builder

# Install Hugo
# BuildKit sets TARGETARCH; default for the legacy builder
ARG TARGETARCH=amd64
ARG HUGO_VERSION=0.163.3
# SHA256 of the upstream tarballs, from the release's hugo_${HUGO_VERSION}_checksums.txt.
# The build fails closed if the downloaded tarball does not match.
RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates && \
    case "${TARGETARCH}" in \
      amd64) HUGO_SHA256=1234302ece1167cef2c252aaa69c89b4f0afc5851f1a30536d693e8e7fc4d1bf ;; \
      arm64) HUGO_SHA256=aa1c95375016b0cfd040f25689da980246ca77a2205f5df9de7e362c93b3d4d4 ;; \
      *) echo "unsupported TARGETARCH: ${TARGETARCH}" >&2; exit 1 ;; \
    esac && \
    wget -q https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz && \
    echo "${HUGO_SHA256}  hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz" | sha256sum -c - && \
    tar -xzf hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz && \
    mv hugo /usr/local/bin/hugo && \
    rm hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz

WORKDIR /project

COPY . .

RUN hugo --baseURL https://jaswdr.dev --cleanDestinationDir --minify

# Production stage (unprivileged: master process runs as the nginx user, listens on 8080)
FROM nginxinc/nginx-unprivileged:1.27-alpine

COPY --from=builder /project/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY security-headers.conf /etc/nginx/security-headers.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
