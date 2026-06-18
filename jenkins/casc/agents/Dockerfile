FROM jenkins/inbound-agent:latest

USER root

RUN apt-get update && \
    apt-get install -y \
      curl \
      unzip \
      git \
      jq \
      ca-certificates \
      apt-transport-https \
      gnupg \
      lsb-release


RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && \
    apt-get install -y \
      docker-ce-cli \
      docker-buildx-plugin \
      docker-compose-plugin


RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip


RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

USER jenkins