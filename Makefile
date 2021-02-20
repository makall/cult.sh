SHELL=/bin/bash

ifeq (, $(shell curl --version))
$(error curl is a required dependency, more info at https://curl.se/)
endif

ifeq (, $(shell jq --version))
$(error jq is a required dependency, more info at https://stedolan.github.io/jq)
endif

ifeq (, $(shell faker --version))
$(warning faker is an optional dependency, more info at https://faker.readthedocs.io/)
endif

all: test

test:
	@./test.sh

install: cult
	install cult /usr/local/bin
