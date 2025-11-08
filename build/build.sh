#!/bin/sh

# docker buildx create --platform linux/amd64,linux/arm64/v8 --use

DOCKERFILE=../Dockerfile
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_REF=$(git rev-parse HEAD)
VCS_URL=$(git config --get remote.origin.url)
VERSION=$(cat VERSION)
IMAGE=git.desertflood.com/jmartindf/docker-pelican

do_build() {
	do_restore
	#docker buildx build --platform linux/arm64 --load \
	docker builder build --platform linux/arm64,linux/amd64 \
		--build-arg BUILD_DATE="$BUILD_DATE" \
		--build-arg VCS_REF="$VCS_REF" \
		--build-arg VCS_URL="$VCS_URL" \
		--build-arg VERSION="$VERSION" \
		-t "$IMAGE:$VERSION" \
		-t "$IMAGE:latest" ../ &&
		finch push --all-platforms "$IMAGE:$VERSION" &&
		finch push --all-platforms "$IMAGE:latest"
}

do_release() {
	do_restore
	sed -i.bak 's#r_BUILD_DATE#'"$BUILD_DATE"'#g' $DOCKERFILE
	sed -i.bak 's#r_VCS_REF#'"$VCS_REF"'#g' $DOCKERFILE
	sed -i.bak 's#r_VCS_URL#'"$VCS_URL"'#g' $DOCKERFILE
	sed -i.bak 's#r_VERSION#'"$VERSION"'#g' $DOCKERFILE
	rm -f $DOCKERFILE.bak
}

do_restore() {
	cp Dockerfile.tmpl $DOCKERFILE
}

case "$1" in
build)
	do_build
	;;
release)
	do_release
	;;
restore)
	do_restore
	;;
*)
	echo "Usage: $NAME {build|release|restore}" >&2
	exit 1
	;;
esac

exit 0
