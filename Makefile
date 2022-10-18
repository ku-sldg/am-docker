IMAGE := cake-am
TAG := latest

.PHONY: image_ubuntu
image_ubuntu: Dockerfile
	rm -rf ku-mst
	git clone git@github.com:ku-sldg/ku-mst.git ku-mst
	docker image build . -t "${DOCKER_REGISTRY}/${IMAGE}_ubuntu:${TAG}"
	rm -rf ku-mst

.PHONY: image_fedora
image_fedora: fedora.Dockerfile
	rm -rf ku-mst
	git clone git@github.com:ku-sldg/ku-mst.git ku-mst
	docker image build -f fedora.Dockerfile . -t "${DOCKER_REGISTRY}/${IMAGE}_fedora:${TAG}"
	rm -rf ku-mst

.PHONY: push
push:
	docker push "${DOCKER_REGISTRY}/${IMAGE}:${TAG}"

.PHONY: run_ubuntu
run_ubuntu:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}_ubuntu:${TAG}" bash

.PHONY: run_fedora
run_fedora:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}_fedora:${TAG}" bash

.PHONY: tests
tests:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}:${TAG}" /scripts/tests.sh

.PHONY: tests_tpm
tests_tpm:
	docker run --rm -it "${DOCKER_REGISTRY}/${IMAGE}:${TAG}" /scripts/tests_tpm.sh

