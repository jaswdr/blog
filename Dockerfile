FROM ghcr.io/gohugoio/hugo:v0.148.2

WORKDIR /project

COPY . .

CMD ["server", "--minify", "--noBuildLock", "--bind", "0.0.0.0", "-b", "https://jaswdr.dev", "--port", "80", "--appendPort=false", "--watch=false"]
