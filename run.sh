#!/bin/bash

wd=$(pwd)

# Maps simpleHTTPServer 8000 to 80 externally
# Makes blog directory appear in /project
# Makes pelican plugins dir appear in /project
# Makes pelican themes dir appear in /project
docker rm -f pelicanbox
docker run \
--name pelicanbox \
-p 80:8000 \
-v $wd/git/.gitconfig:/root/.gitconfig \
-v $wd/gnupg:/root/.gnupg \
-v $wd/ssh:/root/.ssh \
-ti \
chrisramsay/docker-pelicanbox:latest \
/bin/bash
