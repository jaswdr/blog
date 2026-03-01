# Makefile for Hugo Website Development

HUGO := hugo
DOCKER := docker
IMAGE_NAME := website

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available commands
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: serve
serve: ## Run Hugo development server with drafts and live reload
	$(HUGO) serve --buildDrafts --buildFuture

node_modules: package.json
	npm install
	touch node_modules

.PHONY: build
build: node_modules ## Build the static site into the public/ directory
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

.PHONY: new-page
new-page: ## Create a new page (usage: make new-page name=about)
	@if [ -z "$(name)" ]; then echo "Error: 'name' is required (e.g., make new-page name=about)"; exit 1; fi
	$(HUGO) new $(name).md

.PHONY: check
check: ## Run Hugo server with internal server to check site integrity
	$(HUGO) server --renderToDisk
