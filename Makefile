IMAGE := cake-am
TAG := latest

.PHONY: image
image: Dockerfile
	rm -rf ku-mst
	git clone git@github.com:ku-sldg/ku-mst.git ku-mst
	docker image build . -t "${DOCKER_REGISTRY}/${IMAGE}:${TAG}"
	rm -rf ku-mst

.PHONY: push
push:
	docker push "${DOCKER_REGISTRY}/${IMAGE}:${TAG}"

.PHONY: run
run:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}:${TAG}" bash

.PHONY: tests
tests:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}:${TAG}" /scripts/tests.sh

.PHONY: tests_tpm
tests_tpm:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}:${TAG}" /scripts/tests_tpm.sh

