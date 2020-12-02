ARG BASE_IMAGE
FROM $BASE_IMAGE
ARG PYTHON_VERSION
RUN if [ x3 = x"$PYTHON_VERSION" ]; then \
        apk add --no-cache python3 python3-dev; \
        ln -s /usr/bin/python3 /usr/bin/python; \
        which pip3 && ln -s /usr/bin/pip3 /usr/bin/pip \
        || ( \
            apk -U add --no-cache curl \
            && ( \
                curl --proto '=https' --tlsv1.2 -sSf https://bootstrap.pypa.io/get-pip.py | python; \
            ) \
        ); \
    else \
        apk add --no-cache python python-dev curl || apk add --no-cache python2 python2-dev curl; \
        curl --proto '=https' --tlsv1.2 -sSf https://bootstrap.pypa.io/get-pip.py | python; \
    fi \
    && pip --no-cache install --upgrade pip wheel \
    && rm -rf /root/.cache
