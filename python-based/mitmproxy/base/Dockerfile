ARG BASE_IMAGE
FROM $BASE_IMAGE
RUN apk -U add --no-cache libstdc++ \
    && apk -U add --no-cache --virtual remove \
        g++ \
        gcc \
        libffi-dev \
        musl-dev \
        openssl-dev \
        python3-dev \
    && pip install mitmproxy \
    && apk del remove \
    && rm -rf /root/.cache
# TODO: use tini or other init
ENTRYPOINT [ "mitmdump" ]
