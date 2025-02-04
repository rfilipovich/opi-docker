mkfile_path := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
mkfile_dir := $(shell cd $(shell dirname $(mkfile_path)); pwd)
current_dir := $(notdir $(mkfile_dir))
build_number := $(shell date +%Y%m%d%H%M)
host_name := $(shell hostname)
host_home := $(HOME)

IMAGE := dockerdata
IMAGE_ID := opi_pressure_sniffer_$(shell whoami)
IMAGE_TAG := v1
SOURCES := $(mkfile_dir)

WORKDIR:=/home/docker/opi

DOCKER := docker
DOCKER += run --rm -it
DOCKER += -v $(SOURCES):$(WORKDIR)
DOCKER += --net=host
#DOCKER += --security-opt apparmor=unconfined --security-opt seccomp=unconfined --security-opt systempaths=unconfined
DOCKER += -v /dev/bus/usb:/dev/bus/usb
DOCKER += --privileged

DOCKER += $(IMAGE_ID):$(IMAGE_TAG)


#all: docker get_sources build
all: docker build

#get_sources:
#	$(mkfile_dir)/get_sources.sh

#build:
#	$(DOCKER) /bin/bash -i "$(WORKDIR)/go.sh" || :;

# open docker shell (for debug and etc)
sh:
	$(DOCKER) /bin/bash || :;

# generate(regenerate) docker image
docker:
	cp -r $(host_home)/.ssh ./dockerdata/
	cp $(host_home)/.gitconfig ./dockerdata/
	docker build -t $(IMAGE_ID):$(IMAGE_TAG) --build-arg USER_ID=$(shell id -u) $(mkfile_dir)/$(IMAGE)
	rm -rf ./dockerdata/.ssh && rm -rf ./dockerdata/.gitconfig

