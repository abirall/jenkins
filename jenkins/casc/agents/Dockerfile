FROM jenkins/inbound-agent:latest

USER root

RUN apt-get update && \
    apt-get install -y \
      ca-certificates \
      curl \
      unzip \
      gnupg \
      lsb-release \
      gosu \
      iproute2 \
      wireguard-tools && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
      gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch=$(dpkg --print-architecture) \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

RUN groupadd -g 986 docker || true
RUN usermod -aG docker jenkins

RUN apt-get update && \
    apt-get install -y \
      docker-ce-cli \
      docker-buildx-plugin \
      docker-compose-plugin


RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "/tmp/awscliv2.zip" \
    &&  unzip /tmp/awscliv2.zip -d /tmp\
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip


RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

USER jenkins