#!/bin/sh
HUGO_ARCH=""
if [ ${TARGETPLATFORM} = "linux/amd64" ];
then
	HUGO_ARCH="Linux-64bit"
elif [ ${TARGETPLATFORM} = "linux/arm64" ];
then
	HUGO_ARCH="Linux-ARM64"
fi
HUGO_ID="hugo${HUGO_TYPE}_${HUGO_VERSION}_${HUGO_ARCH}"
if [ "${HUGO_ARCH}" != "" ];
then
	mkdir -p /tmp/hugo
	wget -O /tmp/hugo/hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}.tar.gz"
	ls -lh /tmp/hugo
	tar xzf /tmp/hugo/hugo.tar.gz -C /tmp/hugo \
	  && mkdir -p /usr/local/sbin \
	  && mv /tmp/hugo/hugo /usr/local/sbin/hugo \
	  && rm -rf /tmp/hugo
fi
