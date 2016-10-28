FROM debian:latest
MAINTAINER Chris Ramsay <chris@ramsay-family.net>

ENV HOME /root

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="2016-10-28T07:28:17Z" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for maintaining a Pelican web site" \
      org.label-schema.url="https://github.com/chrisramsay/docker-pelican" \
      org.label-schema.vcs-ref="f8904fdd2254593d48a61bb6c7eb22b93aa04e33" \
      org.label-schema.vcs-url="git@github.com:chrisramsay/docker-pelican.git" \
      org.label-schema.vendor="Chris Ramsay" \
      org.label-schema.version="0.5.0" \
      org.label-schema.schema-version="1.0"

RUN apt-get -y update && apt-get install -y \
  python \
  python-dev \
  python-pip \
  git

WORKDIR /srv
ADD requirements.txt /srv/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ADD files/bashrc /root/.bashrc
