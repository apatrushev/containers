#!/bin/sh
PORT=22022


[ -z "$NETWORK" ] && {
    >&2 echo "please provide zerotier network in variable"
    exit 1
}


>&2 echo "ssh waiting zerotier"
while ! zerotier-cli info; do sleep 1; done
zerotier-cli join $NETWORK
while ! zerotier-cli get $NETWORK status | grep ^OK; do sleep 1; done
>&2 echo "zerotier connected, starting ssh"


for key in rsa dsa ecdsa ed25519; do
    [ -e "/etc/ssh/ssh_host_${key}_key" ] || {
        ssh-keygen -f /etc/ssh/ssh_host_${key}_key -N '' -t ${key}
    }
done


exec /usr/sbin/sshd -De -oListenAddress=$(zerotier-cli get $NETWORK ip4) -p $PORT
