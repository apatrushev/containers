# Alpine docker image builder
**Paranoid mode on.**
This is helper utilities to build bare bone alpine images to use in container environment.
It uses publically available containers only for bootstrap though everything else will
be build directly from alipe package repositories. Strictly speaking it is not a defence
of your environment from all forms of intrusions from containers registries but from most of them.


## Usage examples
Just build image of v3.12 based on self image of pre-existing v3.11
```shell
make rootfs.tar.xz VERSION=v3.12 SELF_ALPINE=true BOOTSTRAP=alpine:v3.11
```
Install pre-build rootfs from current folder, or build v3.12 image based
on alpine:edge fetched from default container registry
```
make install VERSION=v3.12
```
Install as described above and tag as alpine:latest
```
make latest VERSION=v3.12
```


## Available Makefile options
* VERSION - alpine version to install
* BOOTSTRAP - docker image to be used for bootstrap (should work on alpine and ubuntu images)
* SELF_ALPINE
  - true: use only images available in docker, do not fetch, fail if not available
  - false: forces fetching image from registry, if we had one, preserve it by temporary renaming
* IMAGE - (internal) image and container names to use during build
* BUILD_NETWORK - network to be used during build
* MIRROR_BASE - mirror to use during installation and integrate to image
* INSTALL_ARCH - target image architecture
* PACKAGES - additional packages to include in target image
