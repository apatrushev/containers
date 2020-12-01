VERSION?=edge

BOOTSTRAP?=alpine:edge
SELF_ALPINE?=false
IMAGE?=alpine-builder
CONTAINER?=$(IMAGE)
BUILD_NETWORK?=default


latest: install
	docker tag alpine:$(VERSION) alpine

install: rootfs.tar.xz
	$$(which pv && echo ' ' || echo 'dd if=')rootfs.tar.xz \
	| docker import - alpine:$(VERSION)

rootfs.tar.xz: Dockerfile install.sh Makefile alpine-builder-fix/*
	[ "$(SELF_ALPINE)" == "true" ] && ( \
		docker tag $(BOOTSTRAP) $(IMAGE) \
	) || ( \
		docker tag $(BOOTSTRAP) alpine:$(IMAGE); docker rmi $(BOOTSTRAP); \
		docker pull $(BOOTSTRAP) \
		&& docker tag $(BOOTSTRAP) $(IMAGE) \
		&& docker rmi $(BOOTSTRAP); \
		docker tag alpine:$(IMAGE) $(BOOTSTRAP) \
		&& docker rmi alpine:$(IMAGE); true \
	)

	# fix our builder image (add some packages)
	docker build --network $(BUILD_NETWORK) -t $(IMAGE) alpine-builder-fix

	# core build steps
	docker build --network $(BUILD_NETWORK) -t $(IMAGE) . # build new builder image
	docker rm $(CONTAINER); true # remove old builder container instance if any
	docker run --network $(BUILD_NETWORK) -ti \
		--name $(CONTAINER) \
		--env VERSION=$(VERSION) \
		--env INSTALL_ARCH=$(INSTALL_ARCH) \
		--env MIRROR_BASE=$(MIRROR_BASE) \
		--env PACKAGES=$(PACKAGES) \
		$(IMAGE)
	docker cp $(CONTAINER):/rootfs.tar.xz . # copy alpine image from builder instance
	docker rm $(CONTAINER) # cleanup
	docker rmi $(IMAGE)

clean:
	rm rootfs.tar.xz; true
	docker rmi $(IMAGE); true

hetzner:
	make install MIRROR_BASE=http://mirror1.hs-esslingen.de/pub/Mirrors/alpine

yandex:
	make install MIRROR_BASE=http://mirror.yandex.ru/mirrors/alpine
