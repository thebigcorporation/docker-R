ORG_NAME := hihg-um
PROJECT_NAME ?= r
OS_BASE ?= ubuntu
OS_VER ?= 22.04

USERID := `id -u`
USERGID := `id -g`

IMAGE_REPOSITORY :=
IMAGE := $(USER)/$(PROJECT_NAME):latest
# Use this for debugging builds. Turn off for a more slick build log
DOCKER_BUILD_ARGS := --progress=plain

.PHONY: all build clean test tests

all: docker test
tests: test

test:

clean:
	@docker rmi $(IMAGE)

docker:

	@docker build -t $(ORG_NAME)/$(USER)/$@ \
		$(DOCKER_BUILD_ARGS) \
		--build-arg BASE_IMAGE=$(OS_BASE):$(OS_VER) \
		--build-arg USERNAME=$(USER) \
		--build-arg USERID=$(USERID) \
		--build-arg USERGID=$(USERGID) \
		.

release:
	docker push $(IMAGE_REPOSITORY)/$(IMAGE)
