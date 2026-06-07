FROM jenkins/jenkins:lts

USER root
RUN apt-get update && \
    apt-get install -y docker.io

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli \
    --plugin-file /usr/share/jenkins/ref/plugins.txt
COPY casc/ /var/jenkins_home/casc/
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc
USER jenkins