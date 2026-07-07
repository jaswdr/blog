# Build stage
FROM debian:stable-slim AS builder

# Install Hugo
# BuildKit sets TARGETARCH; default for the legacy builder
ARG TARGETARCH=amd64
RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates && \
    wget -q https://github.com/gohugoio/hugo/releases/download/v0.163.3/hugo_extended_0.163.3_linux-${TARGETARCH}.tar.gz && \
    tar -xzf hugo_extended_0.163.3_linux-${TARGETARCH}.tar.gz && \
    mv hugo /usr/local/bin/hugo && \
    rm hugo_extended_0.163.3_linux-${TARGETARCH}.tar.gz

WORKDIR /project

COPY . .

RUN hugo --baseURL https://jaswdr.dev --cleanDestinationDir --minify

# Production stage
FROM nginx:alpine

COPY --from=builder /project/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY security-headers.conf /etc/nginx/security-headers.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
