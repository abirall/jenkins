#!/usr/bin/env bash

###############################################################################
# Docker Complete Installation Script
# Supported OS:
#   - Ubuntu 22.04
#   - Ubuntu 24.04
#
# Author: Abir
###############################################################################

set -e

echo "========================================"
echo "Docker Installation Started"
echo "========================================"

#############################################
# Update System
#############################################

sudo apt update
sudo apt upgrade -y

#############################################
# Remove Old Docker Versions
#############################################

echo "Removing old Docker packages..."

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt remove -y $pkg || true
done

#############################################
# Install Required Packages
#############################################

sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common

#############################################
# Docker GPG Key
#############################################

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor \
-o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

#############################################
# Docker Repository
#############################################

echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

#############################################
# Install Docker
#############################################

sudo apt update

sudo apt install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

#############################################
# Enable Docker
#############################################

sudo systemctl enable docker
sudo systemctl restart docker

#############################################
# Configure Docker Group
#############################################

sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker "$USER"

#############################################
# Configure containerd
#############################################

sudo mkdir -p /etc/containerd

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null

sudo systemctl restart containerd

#############################################
# Docker Information
#############################################

echo
echo "Docker Version"
docker --version

echo
echo "Docker Compose Version"
docker compose version

echo
echo "Docker Buildx Version"
docker buildx version

#############################################
# Test Docker
#############################################

echo
echo "Running hello-world..."

sudo docker run --rm hello-world

#############################################
# Display Status
#############################################

echo
echo "Docker Service Status"

sudo systemctl --no-pager status docker

#############################################
# Useful Commands
#############################################

echo
echo "========================================"
echo "Docker Installed Successfully!"
echo "========================================"

echo
echo "Useful Commands:"
echo
echo "docker --version"
echo "docker compose version"
echo "docker ps"
echo "docker images"
echo "docker volume ls"
echo "docker network ls"
echo "docker system df"
echo "docker system prune -a"
echo "docker info"

echo
echo "IMPORTANT!"
echo "Log out and log back in"
echo "or run:"
echo
echo "newgrp docker"
echo
echo "so Docker can run without sudo."
