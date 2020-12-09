ARG BASE_IMAGE
FROM $BASE_IMAGE
RUN apk -U add --no-cache zerotier-one \
	&& rm -rf /var/cache/apk/*
VOLUME /var/lib/zerotier-one
ADD local.conf /var/lib/zerotier-one/
CMD zerotier-one -U
