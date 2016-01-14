#!/bin/bash

wd=$(pwd)
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
