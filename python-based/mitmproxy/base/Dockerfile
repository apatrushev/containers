ARG BASE_IMAGE
FROM $BASE_IMAGE
RUN apk -U add --no-cache libstdc++ \
    && apk -U add --no-cache --virtual remove \
        curl \
        g++ \
        gcc \
        libffi-dev \
        musl-dev \
        openssl-dev \
        python3-dev \
    && curl https://static.rust-lang.org/rustup/dist/aarch64-unknown-linux-musl/rustup-init \
        --output /tmp/rustup-init \
    && chmod +x /tmp/rustup-init \
    && /tmp/rustup-init -y \
    && source $HOME/.cargo/env \
    && pip install --no-cache-dir mitmproxy \
    && rustup self uninstall -y && rm /tmp/rustup-init \
    && apk del remove \
    && rm -rf /root/.cache
VOLUME /root/.mitmproxy
# TODO: use tini or other init
ENTRYPOINT [ "mitmdump" ]
