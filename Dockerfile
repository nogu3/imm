FROM ubuntu:22.04

ARG UID=50000

# -qq = Dont show log without error.
RUN apt-get update \
    && apt-get install -y \
      curl \
      vim \
      # ruby install
      ruby-full \
      # require gem install
      make \
      build-essential \
      libssl-dev \
      libffi-dev \
      python3-dev \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/imm/workspace

# install ruby library
RUN gem install bundler

# create requied dir
RUN mkdir ./src && \
    cd ./src

ADD ./src/Gemfile ./Gemfile

RUN bundle install

# install aws-cli
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp/ && /tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin

RUN useradd -U -u $UID -m imm -s /bin/bash

USER imm