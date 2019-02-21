FROM jenkins/jenkins:lts-alpine

# Parent container switches to "jenkins" user, so we need to revert that.
# Don't switch back because Docker will stop working.
USER root

RUN apk add --no-cache \
            ca-certificates \
            curl \
            m4 \
            make \
            openssl \
            py-pip \
    && rm -rf /var/cache/apk/*

# Installing Docker and Compose...
# See https://hub.docker.com/_/docker/ for updates.
# This install script copied from
# https://github.com/docker-library/docker/blob/c2943e9a0803eea85526f63510a0a8c1e38630d5/18.06/Dockerfile

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.06.2-ce

RUN set -eux; \
	if ! wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for '${dockerArch}'"; \
		exit 1; \
	fi; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	docker --version

RUN pip install docker-compose
