.PHONY: build
build: build-x86 build-ppc64le build-s390x ## build all nginx docker

.PHONY: build-x86
build-x86: ## build x86 nginx docker
	docker build -t nginx-stress-test-site-x86 -f Dockerfile .
	docker build -t nginx-stress-test-site-x86-without-gzip -f Dockerfile.without_gzip .

.PHONY: build-ppc64le
build-ppc64le: ## build ppc64le nginx docker
	docker build -t nginx-stress-test-site-ppc64le --build-arg BASE_IMAGE=ppc64le/nginx:1.20.2-alpine -f Dockerfile .
	docker build -t nginx-stress-test-site-ppc64le-without-gzip \
		--build-arg BASE_IMAGE=ppc64le/nginx:1.20.2-alpine -f Dockerfile.without_gzip .

.PHONY: build-s390x
build-s390x: ## build s390x nginx docker
	docker build -t nginx-stress-test-site-s390x --build-arg BASE_IMAGE=s390x/nginx:1.20.2-alpine -f Dockerfile .
	docker build -t nginx-stress-test-site-s390x-without-gzip \
		--build-arg BASE_IMAGE=s390x/nginx:1.20.2-alpine -f Dockerfile.without_gzip .

.PHONY: help
help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_0-9-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: load-test
load-test: ## load-test 
	JMETER="docker.io/kaichu1016/jmeter" \
	JMETER_VERSION="5.4.2" \
	TARGET_HOST="192.168.1.201" \
	TARGET_PORT="8080" \
	TARGET_PATH="/" \
	THREADS="20" \
	RAMD_UP="40" \
	DURATION="60" \
	SETUP_DELAY="5" \
	./test.sh

.PHONY: pull
pull:
	git fetch --all
	git reset --hard origin/master

.PHONY: push
push:
	git add .
	git commit --amend --no-edit
	git push -f

.DEFAULT_GOAL := help