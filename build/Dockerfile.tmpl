FROM debian:latest
MAINTAINER Joe Martin <joe@desertflood.com>

ENV HOME /root

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL org.label-schema.build-date="r_BUILD_DATE" \
      org.label-schema.name="aws-gen" \
      org.label-schema.description="Machine for maintaining a Pelican web site" \
      org.label-schema.url="https://github.com/jmartindf/docker-pelican" \
      org.label-schema.vcs-ref="r_VCS_REF" \
      org.label-schema.vcs-url="r_VCS_URL" \
      org.label-schema.vendor="Joe Martin" \
      org.label-schema.version="r_VERSION" \
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

# Cleanup the container
RUN apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD files/bashrc /root/.bashrc
ADD buildserver/server.py /srv/server.py
ADD buildserver/startup.sh /srv/startup.sh
ADD buildserver/update_repo.sh /srv/update_repo.sh

CMD ["/srv/startup.sh","8067"]
