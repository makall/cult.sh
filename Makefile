SHELL=/usr/bin/bash

ifeq (, $(shell command -v curl))
$(error curl is a required dependency, more info at https://curl.se/)
endif

ifeq (, $(shell command -v jq))
$(error jq is a required dependency, more info at https://stedolan.github.io/jq)
endif

ifeq (, $(shell command -v faker))
$(error faker is a required dependency, more info at https://faker.readthedocs.io/)
endif

all: test

test:
	@./test.sh

install: cult
	install cult /usr/bin
