FROM debian:latest
MAINTAINER Chris Ramsay <chris@ramsay-family.net>

ENV HOME /root

# Update & add prerequisites
RUN apt-get -y update && apt-get install -y \
  python \
  python-dev \
  python-pip \
  git

# Python packages
RUN pip install \
  Fabric \
  Jinja2 \
  Markdown \
  MarkupSafe \
  Pygments \
  Unidecode \
  argparse \
  beautifulsoup4 \
  blinker \
  docutils \
  ecdsa \
  feedgenerator \
  paramiko \
  pelican \
  pycrypto \
  python-dateutil \
  pytz \
  six \
  smartypants \
  typogrify \
  wsgiref

ADD files/bashrc /root/.bashrc