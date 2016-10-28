#!/bin/bash

###
# Add more mounts for your projects after the git/gnupg/ssh ones
# e.g. -v ~/stuff/myproject:/project \

wd=$(pwd)
img=docker-pelican
if docker ps | grep $img | awk '{ print $11 }'
    then
    com=$(docker rm -f $img)
    echo "Removed ${com}"
fi
docker run \
--name $img \
-p 80:8000 \
-v $wd/git/.gitconfig:/root/.gitconfig \
-v $wd/gnupg:/root/.gnupg \
-v $wd/ssh:/root/.ssh \
-v ~/Stuff/blog-box/chrisramsay.co.uk:/project \
-v ~/Stuff/pelican-plugins:/project/pelican-plugins  \
-v ~/Stuff/pelican-themes:/project/pelican-themes \
-ti \
chrisramsay/$img:latest \
/bin/bash
