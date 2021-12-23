.PHONY: build-x86
build-x86: ## build x86 nginx docker
	BASE_IMAGE=nginx:1.20.2-alpine \
	CONFIG_FILE=default.conf.gz \
	IMAGE=ghcr.io/cage1016/nginx-website-gz \
	VERSION=0.1.0 \
	./build.sh

	BASE_IMAGE=nginx:1.20.2-alpine \
	CONFIG_FILE=default.conf \
	IMAGE=ghcr.io/cage1016/nginx-website \
	VERSION=0.1.0 \
	./build.sh

# .PHONY: build-ppc64le
# build-ppc64le: ## build ppc64le nginx docker
# 	docker build -t nginx-stress-test-site-ppc64le --build-arg BASE_IMAGE=ppc64le/nginx:1.20.2-alpine -f Dockerfile .
# 	docker build -t nginx-stress-test-site-ppc64le-without-gzip \
# 		--build-arg BASE_IMAGE=ppc64le/nginx:1.20.2-alpine -f Dockerfile.without_gzip .

.PHONY: build-s390x
build-s390x: ## build s390x nginx docker
	DAEMON=podman \	
	BASE_IMAGE=s390x/nginx:1.20.2-alpine \
	CONFIG_FILE=default.conf.gz \
	IMAGE=ghcr.io/cage1016/nginx-website-gz-s390x \
	VERSION=0.1.0 \
	./build.sh

	DAEMON=podman \
	BASE_IMAGE=s390x/nginx:1.20.2-alpine \
	CONFIG_FILE=default.conf \
	IMAGE=ghcr.io/cage1016/nginx-website-s390x \
	VERSION=0.1.0 \
	./build.sh

.PHONY: help
help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_0-9-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.DEFAULT_GOAL := help