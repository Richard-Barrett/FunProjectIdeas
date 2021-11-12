MKFILE_DIR := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
MOD_PATH := github.com/Richard-Barrett/FunProjectIdeas
IMAGE_NAME ?= rbarrett89/funprojectideas
IMAGE_TAG ?= latest

.PHONY: funprojectideas
funprojectideas: 
	docker build $(MKFILE_DIR) -t $(IMAGE_NAME):$(IMAGE_TAG)