#!/bin/sh

DOCKERFILE=../Dockerfile
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_REF=$(git rev-parse HEAD)
VCS_URL=$(git config --get remote.origin.url)
VERSION=$(cat VERSION)
IMAGE=chrisramsay/docker-pelican

do_build_latest()
{
    do_restore
    docker build --build-arg BUILD_DATE=$BUILD_DATE \
                 --build-arg VCS_REF=$VCS_REF \
                 --build-arg VCS_URL=$VCS_URL \
                 --build-arg VERSION=$VERSION \
                 -t $IMAGE:latest ../
}

do_build_version()
{
    do_restore
    docker build --build-arg BUILD_DATE=$BUILD_DATE \
                 --build-arg VCS_REF=$VCS_REF \
                 --build-arg VCS_URL=$VCS_URL \
                 --build-arg VERSION=$VERSION \
                 -t $IMAGE:$VERSION ../
}

do_release()
{
    do_restore
    sed -i.bak 's#BUILD_DATE#'"$BUILD_DATE"'#g' $DOCKERFILE
    sed -i.bak 's#VCS_REF#'"$VCS_REF"'#g' $DOCKERFILE
    sed -i.bak 's#VCS_URL#'"$VCS_URL"'#g' $DOCKERFILE
    sed -i.bak 's#VERSION#'"$VERSION"'#g' $DOCKERFILE
    rm -f $DOCKERFILE.bak
}

do_restore()
{
    cp Dockerfile.tmpl $DOCKERFILE
}

case "$1" in
    build-latest)
        do_build_latest
        ;;
    build-version)
        do_build_version
        ;;
    release)
        do_release
        ;;
    restore)
        do_restore
        ;;
*)
echo "Usage: $NAME {build-latest|build-version|release|restore}" >&2
exit 1
esac

exit 0
