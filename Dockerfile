FROM jenkins:2.19.2

# Parent container switches to "jenkins" user, so we need to revert that.
# Don't switch back because Docker will stop working.
USER root

# Install Docker and Compose
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates && \
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
	apt-get update && \
	apt-get install -y docker-engine python-pip && \
	pip install docker-compose && \
	rm -rf /var/lib/apt/lists/*
