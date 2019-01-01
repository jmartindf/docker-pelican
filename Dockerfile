FROM debian:latest
MAINTAINER Joe Martin <joe@desertflood.com>

ENV HOME /root
ENV HUGO_VERSION=0.53
#ENV HUGO_TYPE=
ENV HUGO_TYPE=_extended
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="2019-01-01T21:13:20Z" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for maintaining a Pelican web site" \
      org.label-schema.url="https://github.com/jmartindf/docker-pelican" \
      org.label-schema.vcs-ref="41c1ea257285ed3b08b364cabf503b5c78b90f01" \
      org.label-schema.vcs-url="git@github.com:jmartindf/docker-pelican.git" \
      org.label-schema.vendor="Joe Martin" \
      org.label-schema.version="1.1.0" \
      org.label-schema.schema-version="1.0"

RUN apt-get -y update && apt-get install -y \
  python3.4 \
  python3.4-dev \
  python3-pip \
  libffi-dev \
  libssl-dev \
  locales \
  git && \
  sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen && \
  update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 && \
  pip install --upgrade pip && \
  update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip 2 && \
  git clone --recursive https://github.com/getpelican/pelican-plugins.git /pelican-plugins

ADD requirements.txt /srv/requirements.txt
WORKDIR /srv
RUN pip install -r requirements.txt

# Install Hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz /tmp
RUN tar -xf /tmp/${HUGO_ID}_Linux-64bit.tar.gz -C /tmp \
  && mkdir -p /usr/local/sbin \
  && mv /tmp/hugo /usr/local/sbin/hugo \
  && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
  && rm -rf /tmp/${HUGO_ID}_Linux-64bit.tar.gz \
  && rm -rf /tmp/LICENSE.md \
  && rm -rf /tmp/README.md

# Cleanup the container
RUN apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD files/bashrc /root/.bashrc
ADD buildserver/server.py /srv/server.py
ADD buildserver/startup.sh /srv/startup.sh
ADD buildserver/update_repo.sh /srv/update_repo.sh

CMD ["/srv/startup.sh","8067"]
