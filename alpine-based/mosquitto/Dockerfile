ARG BASE_IMAGE
FROM $BASE_IMAGE
RUN apk -U add mosquitto \
	&& rm -rf /var/cache/apk/*
CMD mosquitto
