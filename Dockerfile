FROM debian:bullseye
MAINTAINER Joe Martin <joe@desertflood.com>

ENV HOME /root
ARG HUGO_VERSION=0.105.0
ARG HUGO_TYPE=
#ENV HUGO_TYPE=_extended
ARG TARGETPLATFORM

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="2022-11-14T23:04:25Z" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for maintaining a Pelican web site" \
      org.label-schema.url="https://github.com/jmartindf/docker-pelican" \
      org.label-schema.vcs-ref="3ec6ee28a992b4daab0d1ec1a4418d77bb3b9f44" \
      org.label-schema.vcs-url="git@github.com:jmartindf/docker-pelican.git" \
      org.label-schema.vendor="Joe Martin" \
      org.label-schema.version="1.4.1" \
      org.label-schema.schema-version="1.0"

RUN apt-get -y update && apt-get install -y \
  python3.9 \
  python3.9-dev \
  python3-pip \
  libffi-dev \
  libssl-dev \
  locales \
  git \
  wget \
  rsync && \
  sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen && \
  update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 && \
  pip install --upgrade pip && \
  update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip 2 && \
  git clone --recursive https://github.com/getpelican/pelican-plugins.git /pelican-plugins
#
## For future reference
## cd /pelican-plugins
## git checkout `git rev-list -n 1 --first-parent --before="2019-01-01 14:14" master`

# Install Hugo
ADD build/gohugo.sh /tmp/gohugo.sh
RUN /tmp/gohugo.sh \
  && rm -rf /tmp/gohugo.sh

# Install Pelican and dependencies
ADD requirements.txt /srv/requirements.txt
WORKDIR /srv
RUN pip install -r requirements.txt

# Cleanup the container
RUN apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD files/bashrc /root/.bashrc
ADD buildserver/server.py /srv/server.py
ADD buildserver/startup.sh /srv/startup.sh
ADD buildserver/update_repo.sh /srv/update_repo.sh

CMD ["/srv/startup.sh","8067"]
