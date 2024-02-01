FROM jenkins/jenkins:lts-alpine

# Parent container switches to "jenkins" user, so we need to revert that.
# Don't switch back because Docker will stop working.
USER root

RUN apk add --no-cache \
            ca-certificates \
            curl \
            docker \
            docker-cli-compose \
            gcc \
            imagemagick \
            libffi-dev \
            m4 \
            make \
            musl-dev \
            openssl \
            openssl-dev \
            py3-pip \
            python3 \
            python3-dev \
            rsync \
            yarn \
    && rm -rf /var/cache/apk/*

# Installing zopfli (for StaticBrainz jobs)
RUN cd /tmp \
    && git clone https://github.com/google/zopfli \
    && cd zopfli \
    && git checkout zopfli-1.0.3 \
    && make zopfli \
    && install -m 755 zopfli /usr/local/bin/ \
    && cd - \
    && rm -rf /tmp/zopfli
