FROM hugomods/hugo:exts as hugo-builder

WORKDIR /src

COPY config.yml ./
COPY content/ ./content/
COPY layouts/ ./layouts/
COPY static/ ./static/
COPY archetypes/ ./archetypes/
COPY themes/ ./themes/

RUN hugo --minify --gc --cleanDestinationDir

FROM node:24-alpine as optimizer

WORKDIR /app

RUN npm install -g cssnano-cli terser

COPY --from=hugo-builder /src/public ./public

RUN find ./public -name "*.css" -type f -exec sh -c 'cssnano "$1" "$1.tmp" && mv "$1.tmp" "$1"' _ {} \;

RUN find ./public -name "*.js" -not -name "*.min.js" -type f -exec sh -c 'terser "$1" --compress --mangle -o "$1.tmp" && mv "$1.tmp" "$1"' _ {} \;

FROM nginx:alpine

COPY --from=optimizer /app/public /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/cache/nginx/client_temp \
  /var/cache/nginx/proxy_temp \
  /var/cache/nginx/fastcgi_temp \
  /var/cache/nginx/uwsgi_temp \
  /var/cache/nginx/scgi_temp \
  && chown -R nginx:nginx /var/cache/nginx /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
