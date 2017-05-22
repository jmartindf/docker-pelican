FROM debian:latest
MAINTAINER Joe Martin <joe@desertflood.com>

ENV HOME /root

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="2017-05-22T02:52:57Z" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for maintaining a Pelican web site" \
      org.label-schema.url="https://github.com/jmartindf/docker-pelican" \
      org.label-schema.vcs-ref="1e9fa42dd22475aba2d7828815a5cf20e517e5a2" \
      org.label-schema.vcs-url="git@github.com:jmartindf/docker-pelican.git" \
      org.label-schema.vendor="Joe Martin" \
      org.label-schema.version="0.7.1" \
      org.label-schema.schema-version="1.0"

RUN apt-get -y update && apt-get install -y \
  python3.4 \
  python3.4-dev \
  python3-pip \
  libffi-dev \
  libssl-dev \
  locales \
  git && \
  sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen

WORKDIR /srv
ADD requirements.txt /srv/requirements.txt
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 && \
  pip install --upgrade pip && \
  update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip 2 && \
  pip install -r requirements.txt

ADD files/bashrc /root/.bashrc

# Cleanup the container
RUN apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD buildserver/server.py /srv/server.py
CMD ["/srv/server.py","8067"]
