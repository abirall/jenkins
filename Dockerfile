FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
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
    curl -fsSL https://pkgs.netbird.io/install.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

# COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
# RUN jenkins-plugin-cli \
#     --plugin-file /usr/share/jenkins/ref/plugins.txt
# COPY casc/ /var/jenkins_home/casc/
# COPY jobs/ /var/jenkins_home/jobs/
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc

RUN jenkins-plugin-cli --plugins \
    configuration-as-code \
    job-dsl \
    workflow-aggregator \
    git \
    github \
    github-branch-source \
    docker-workflow \
    docker-plugin \
    pipeline-utility-steps \
    build-timeout \
    timestamper \
    ws-cleanup \
    ssh-slaves \
    ssh-agent \
    configuration-as-code-support \
    blueocean


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]