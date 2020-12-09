ARG BASE_IMAGE
FROM $BASE_IMAGE
RUN apk -U add util-linux bash htop \
	&& rm -rf /var/cache/apk/*
CMD nsenter -t 1 -m -u -n -i sh -l
