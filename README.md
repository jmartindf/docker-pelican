# docker-pelican

## Intro

A machine for maintaining a [Pelican](http://docs.getpelican.com/en/stable/) web site with a few extras to handle build tasking using [Git](https://git-scm.com/), [Fabric](http://www.fabfile.org/) and [GPG](https://www.gnupg.org/).

## General Use

Copy the `run.sh.tpl` file to something else, say, `run.sh`. Add any items you might want in the `.gnupg` and `.ssh` directories. Edit your `.gitconfig` file as necessary

```bash
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
-v ~/mydir:/project \
-ti \
chrisramsay/$img:latest \
/bin/bash
```

To run the container:

`$ ./run.sh`

Edit the `run.sh` file to add as many extra mount commands as you need.

## Build Script

There is a `build.sh` file packaged here. This is to help with further development of the container. One of a number of possible options must be passed at run time.

### build-latest

Runs the standard `docker build` command with a few build arguments; tags as latest but picks up build version from the `VERSION` file.

### build-version

Runs the standard `docker build` command with a few build arguments; tags and adds build version from `VERSION` file.

### release

Does not execute `docker build`. Instead modifies the `Dockerfile` replacing in-place values from the `Dockerfile.tmpl` with label values. This should be done prior to a tagged release.

### restore

Used in order to reinstate the normal `Dockerfile` for continuing development. Utility function only.

## Development Process

* Create a new release branch
* Change directory to the `build` directory
* Bump the version number in `build/VERSION`
* Run `$ ./build.sh restore` to set up a clean `Dockerfile`
* Make any required changes to `build/Dockerfile.tmpl`
* Run `$ ./build.sh build-version` or `$ ./build.sh build-latest` as required
* Once all the work is complete, run `$ ./build.sh release`
* Merge and tag the release

***

[![](https://images.microbadger.com/badges/image/chrisramsay/docker-pelican.svg)](https://microbadger.com/images/chrisramsay/docker-pelican "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/chrisramsay/docker-pelican.svg)](https://microbadger.com/images/chrisramsay/docker-pelican "Get your own version badge on microbadger.com")
