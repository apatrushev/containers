#!/bin/sh
set -euxo pipefail
ARCH=${ARCH:-$(uname -m)}
INSTALL_ARCH=${INSTALL_ARCH:-${ARCH}}
VERSION=${VERSION:-edge}
RUNDIR=`pwd`
MIRROR_BASE=${MIRROR_BASE:-http://dl-cdn.alpinelinux.org/alpine}
REPO=${MIRROR_BASE}/${VERSION}/main
PKG=$(curl ${REPO}/${ARCH}/ | fgrep apk-tools-static | sed 's/.*href="//;s/".*//')
[ -n "${PKG}" ] || false
CHROOT_DIR=${CHROOT_DIR:-/tmp/build/root}
PACK=${PACK:-xz}
PACK_CMD="xz -e9 " && [[ "1${PACK}" == "1xz" ]] && PACK_CMD="gzip -9 "
APK_CMD="${CHROOT_DIR}/apk.static -X ${REPO} -U --allow-untrusted --root ${CHROOT_DIR} --arch ${INSTALL_ARCH}"

mkdir -p ${CHROOT_DIR}/etc/apk
curl ${REPO}/${ARCH}/${PKG} | tar -C ${CHROOT_DIR} --strip-components=1 -xz sbin/apk.static
echo ${INSTALL_ARCH} >${CHROOT_DIR}/etc/apk/arch

if [ "${1:-}" == "fetch" ]; then
    ${APK_CMD} --initdb add musl
    ${APK_CMD} fetch ${PACKAGES}
else
    ${APK_CMD} --initdb add alpine-base
    (
        cd ${CHROOT_DIR}/etc/apk
        echo ${REPO} >repositories
        head -1 repositories | sed 's/main$/community/' >>repositories
        head -1 repositories | sed 's/main$/testing/' >>repositories
    )

    if [ -n "${PACKAGES}" ]; then
        cp /etc/resolv.conf ${CHROOT_DIR}/etc
        chroot ${CHROOT_DIR} apk -U add ${PACKAGES}
    fi

    rm -rf ${CHROOT_DIR}/var/cache/apk/APKINDEX*

    if [ "1${PACK}" != "10" ]; then
        tar -C ${CHROOT_DIR} -c . | ${PACK_CMD} -c >${RUNDIR}/rootfs.tar.${PACK}
        rm -rf ${CHROOT_DIR}
    fi
fi
