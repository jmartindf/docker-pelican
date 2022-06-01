#!/bin/sh
if [ $ARCH = "amd64" ];
then
	HUGO_ARCH="Linux-64bit"
elif [ $ARCH = "arm64v8" ];
then
	HUGO_ARCH="Linux-ARM64"
fi
HUGO_ID="hugo${HUGO_TYPE}_${HUGO_VERSION}_${HUGO_ARCH}"
if [ $HUGO_ARCH -neq "" ];
then
	curl  -o /tmp/hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}.tar.gz"
	tar -xf /tmp/hugo.tar.gz -C /tmp \
	  && mkdir -p /usr/local/sbin \
	  && mv /tmp/hugo /usr/local/sbin/hugo \
	  && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
	  && rm -rf /tmp/hugo.tar.gz \
	  && rm -rf /tmp/LICENSE.md \
	  && rm -rf /tmp/README.md
fi
