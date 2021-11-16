ORG_NAME := um
PROJECT_NAME := docker-r
OUTPUTDIR := target
USER ?= `whoami`
IMAGE_REPOSITORY := $(USER)/$(ORG_NAME)/$(PROJECT_NAME):latest

# Use this for debugging builds. Turn off for a more slick build log
DOCKER_BUILD_ARGS := --progress=plain

.PHONY: all build clean test tests

all: clean docker test
tests: test

test:

clean:
	@rm -rf $(OUTPUTDIR)

docker:
	@docker build -t $(IMAGE_REPOSITORY) \
		$(DOCKER_BUILD_ARGS) \
	  .

release:
	docker push $(IMAGE_REPOSITORY)

