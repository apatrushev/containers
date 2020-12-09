ARG BASE_IMAGE
FROM $BASE_IMAGE
RUN apk -U add --no-cache \
        curl \
        docker-cli \
        openssh-server \
        zerotier-one \
    && rm -rf /var/cache/apk/* \
    && sed -i'' 's/^#PasswordAuthentication.*$/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && mkdir /root/.ssh \
    && curl https://apatrushev.keybase.pub/id_rsa.pub >>/root/.ssh/authorized_keys \
    && pip install supervisor
VOLUME /var/lib/zerotier-one
ADD supervisord.conf ssh.sh /
ENTRYPOINT [ "/usr/bin/supervisord", "-nc", "/supervisord.conf" ]
