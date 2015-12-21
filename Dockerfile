FROM debian:latest
MAINTAINER Chris Ramsay <chris@ramsay-family.net>

RUN umask 0077; mkdir $HOME/.ssh

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
ADD ssh/id_rsa $HOME/.ssh/
ADD ssh/id_rsa.pub $HOME/.ssh/
ADD ssh/known_hosts $HOME/.ssh/
ADD gnupg/gpg.conf $HOME/.gnupg/
ADD gnupg/pubring.gpg $HOME/.gnupg/
ADD gnupg/secring.gpg $HOME/.gnupg/
ADD git/.gitconfig $HOME/

RUN chmod -R 700 $HOME/.ssh
RUN chown -R root:root $HOME/.ssh
RUN chmod -R 700 $HOME/.gnupg
RUN chown -R root:root $HOME/.gnupg
RUN chmod 700 $HOME/.gitconfig
RUN chown root:root $HOME/.gitconfig
