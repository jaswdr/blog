# Makefile for Hugo CV site

HUGO := hugo
DOCKER := docker
IMAGE_NAME := website
HUGO_VERSION := 0.163.3

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available commands
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Enable git hooks (validates machine-readable outputs on commit)
	git config core.hooksPath .githooks
	@echo "hooksPath set to .githooks"

.PHONY: check-hugo
check-hugo: ## Verify local Hugo matches the pinned version ($(HUGO_VERSION))
	@v=$$($(HUGO) version 2>/dev/null | sed -n 's/.*v\([0-9.]*\).*/\1/p' | head -1); \
	if [ -z "$$v" ]; then echo "Error: hugo not found on PATH"; exit 1; fi; \
	if [ "$$v" != "$(HUGO_VERSION)" ]; then \
	  echo "Error: hugo $$v found, expected $(HUGO_VERSION) (see Dockerfile)"; exit 1; \
	fi; \
	echo "hugo $(HUGO_VERSION) OK"

.PHONY: serve
serve: ## Run Hugo development server with drafts and live reload
	$(HUGO) serve --buildDrafts --buildFuture

.PHONY: build
build: ## Build the static site into the public/ directory
	$(HUGO) --minify

.PHONY: clean
clean: ## Remove the generated public/ and resources/ directories
	rm -rf public resources

.PHONY: docker-build
docker-build: ## Build the Docker image
	$(DOCKER) build -t $(IMAGE_NAME) .

.PHONY: docker-run
docker-run: ## Run the Docker container locally on port 8080
	$(DOCKER) run -it --rm -p 8080:80 $(IMAGE_NAME)
