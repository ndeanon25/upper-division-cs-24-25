FROM ubuntu:20.04
ENV SHELL=/usr/bin/bash

LABEL maintainer="Upper Division CS <https://github.com/TheEvergreenStateCollege/upper-division-cs-24-25>"

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends
RUN apt-get install -yqq gpg

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends

RUN apt-get install -yqq wget
RUN apt-get install -yqq ca-certificates
RUN apt-get install -yqq ssh
RUN apt-get install -yqq git
RUN apt-get install -yqq sudo
RUN apt-get install -yqq unzip
RUN apt-get install -yqq gcc
RUN apt-get install -yqq zlib1g-dev
RUN apt-get install -yqq htop
RUN apt-get install -yqq asciinema
RUN apt-get install -yqq python3-pip
RUN apt-get install -yqq curl
RUN apt-get install -yqq tcpdump
RUN apt-get install -yqq netcat
RUN apt-get install -yqq telnet
RUN apt-get install -yqq net-tools
RUN apt-get install -yqq nodejs
RUN apt-get install -yqq npm

# For pdf2text
RUN apt-get install -yqq poppler-utils
RUN apt-get install -yqq pkg-config

# For AI assignments
RUN pip3 install html2text
RUN pip3 install tiktoken
RUN pip3 install torch
RUN pip3 install numpy

ENV PATH=${PATH}:/home/gitpod/.local/bin
# add gitpod user
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod
USER gitpod
WORKDIR /home/gitpod

USER root

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir ~/scripts
COPY ./scripts/dl-graalvm.sh /root/scripts/dl-graalvm.sh
COPY ./scripts/.shrc /root/.shrc


# Download the right GraalVM for the given architecture
RUN . /root/scripts/dl-graalvm.sh
RUN . /root/.shrc; gu install nodejs
RUN . /root/.shrc; gu install python

RUN ssh-keyscan github.com

WORKDIR "${HOME}"
