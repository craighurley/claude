#!/usr/bin/env make

MD_LINT_CONTAINER := craighurley/markdownlint-cli:latest
SHELLCHECK_CONTAINER := craighurley/shellcheck:latest
YAML_LINT_CONTAINER := craighurley/yamllint:latest

.DEFAULT_GOAL := help

help: ## Print this help
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*##"}; {printf "  %-10s %s\n", $$1, $$2}'
.PHONY: help

clean: ## Clean
	@echo $@
.PHONY: clean

lint: ## Run linters
	@echo $@
	docker run --rm -v "$$PWD":/workdir:ro $(MD_LINT_CONTAINER) -c .markdownlintrc "**/*.md" -i ./skills
	docker run --rm -v "$$PWD":/workdir:ro $(SHELLCHECK_CONTAINER) **/*.sh
	docker run --rm -v "$$PWD":/workdir:ro $(YAML_LINT_CONTAINER) -c .yamllint ./
.PHONY: lint
