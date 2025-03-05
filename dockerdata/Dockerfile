FROM ubuntu:xenial
MAINTAINER Ruslan Filipovich <ruslan.filipovich@promwad.com>
ARG DEBIAN_FRONTEND=noninteractive

ARG USER_ID
RUN echo "USER_ID: $USER_ID"


RUN dpkg --add-architecture amd64 \
	&& apt-get update \
	&& apt-get upgrade -y \
 	&& apt-get install -y \
	build-essential locales git-core u-boot-tools wget unzip bc python \
	gcc g++ binutils patch bzip2 flex make gettext \
	pkg-config zlib1g-dev libc6-dev subversion libncurses5-dev gawk \
	sharutils curl pv tar sudo libssl-dev \
	device-tree-compiler cpio libelf-dev software-properties-common \
	automake perl bison gperf libxml2-utils zip \
	g++-multilib lib32z1 bash net-tools iputils-ping locales \
	diffstat texinfo gcc-multilib build-essential chrpath socat \
	python3 python3-pip python3-pexpect \
	xz-utils debianutils libsdl1.2-dev

	
RUN apt-get install -y \
	git ssh module-assistant expect libssl-dev \
	fakeroot cmake autoconf passwd openssl \
	openssh-server openssh-client vim file rsync usbutils


RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN chmod -R 0777 /opt

# Set a docker user
RUN ln -sf /bin/bash /bin/sh
#RUN useradd -m -U docker -G sudo
## You should change this uid for your user in system (see output from the command: echo $UID)
RUN useradd  -m -u $USER_ID -U docker -G sudo
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

## set env for docker user ##
WORKDIR /home/docker
USER docker
ENV USER docker

RUN git config --global user.email "ruslan.filipovich@promwad.com"
RUN git config --global user.name "PICO pressure sniffer Docker"

# git & ssh config from the host machine
RUN mkdir /home/docker/.ssh
COPY .ssh  /home/docker/.ssh
COPY .gitconfig  /home/docker/
RUN sudo chown docker:docker -R /home/docker/.ssh
RUN sudo chown docker:docker -R /home/docker/.gitconfig

RUN echo -n > /home/docker/.bash_profile

