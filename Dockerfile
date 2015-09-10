FROM debian:latest
MAINTAINER Chris Ramsay <chris@ramsay-family.net>

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

# Mount volume
RUN mkdir /project
VOLUME /project

# Add certs to allow git pull
ADD ssh/id_rsa /root/.ssh/
ADD ssh/id_rsa.pub /root/.ssh/
ADD ssh/known_hosts /root/.ssh/
RUN chmod -R 700 /root/.ssh
RUN chown -R root:root /root/.ssh
