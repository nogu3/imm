FROM ubuntu:22.04

ARG UID=1000

# -qq = Dont show log without error.
RUN apt-get update \
    && apt-get install -y \
      # utility
      curl \
      vim \
      rbenv \
      git \
      # require ruby 3.2.1
      libyaml-dev \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*

# ruby-build install
RUN git clone --depth=1 https://github.com/rbenv/ruby-build \
    && PREFIX=/usr/local ./ruby-build/install.sh \
    && rm -rf ruby-build

# ruby install 3.2.1
RUN ruby-build 3.2.1 /usr/local

# gem system update
RUN gem update --system 3.4.12

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