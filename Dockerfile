# Build stage
FROM ghcr.io/gohugoio/hugo:v0.148.2 AS builder

WORKDIR /project

COPY . .

RUN hugo --baseURL https://jaswdr.dev --cleanDestinationDir --enableGitInfo --minify --noChmod --noTimes --noBuildLock

# Production stage
FROM nginx:alpine

COPY --from=builder /project/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
