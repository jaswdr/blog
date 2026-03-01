# Build stage
FROM node:24-slim AS builder

# Install Hugo
RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/gohugoio/hugo/releases/download/v0.155.3/hugo_extended_0.155.3_linux-64bit.tar.gz && \
    tar -xzf hugo_extended_0.155.3_linux-64bit.tar.gz && \
    mv hugo /usr/local/bin/hugo && \
    rm hugo_extended_0.155.3_linux-64bit.tar.gz

WORKDIR /project

COPY package*.json ./
RUN npm install

COPY . .

RUN hugo --baseURL https://jaswdr.dev --cleanDestinationDir --minify

# Production stage
FROM nginx:alpine

COPY --from=builder /project/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
