FROM ubuntu:focal

# "sudo": switch user in entrypoint.
# "curl", "build-essential": build Mainframer.
# "openssh-server", "rsync": testing.
RUN apt-get update --quiet > /dev/null && \
    apt-get --assume-yes --no-install-recommends --quiet install \
    sudo \
    curl \
    ca-certificates \
    build-essential \
    openssh-server \
    rsync && \
    apt-get --assume-yes clean

RUN groupadd build_user && \
    useradd --shell /bin/bash --comment "User for container" --create-home -g build_user build_user && \
    usermod -a -G sudo build_user

# Entrypoint script will allow us run as non-root in the container.
COPY ci/docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
