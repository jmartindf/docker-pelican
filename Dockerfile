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

# Add certs to allow digitally signed git pull / push
ADD ssh/id_rsa /root/.ssh/
ADD ssh/id_rsa.pub /root/.ssh/
ADD ssh/known_hosts /root/.ssh/
ADD gnupg/gpg.conf /root/.gnupg/
ADD gnupg/pubring.gpg /root/.gnupg/
ADD gnupg/secring.gpg /root/.gnupg/
ADD git/.gitconfig /root/

RUN chmod -R 700 /root/.ssh
RUN chown -R root:root /root/.ssh
RUN chmod -R 700 /root/.gnupg
RUN chown -R root:root /root/.gnupg
RUN chmod 700 /root/.gitconfig
RUN chown root:root /root/.gitconfig
