DEV := pomodoro.yaml


help:
	@grep -E '(^[0-9a-zA-Z_-]+:.*?##.*$$)|(^##)' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'


.PHONY: git_version
git_version: ## generate git version string
	echo "|-\n  return { \"$$(git describe --match=NeVeRmAtCh --always --dirty)\" };" >.git_version

.PHONY: dep
dep: ## get dependencies via uv
	uv sync

.PHONY: run
run: git_version ## upload to device and stream the logs
	esphome run $(DEV)

.PHONY: upload
upload: git_version ## upload to device
	esphome run --no-logs $(DEV)
