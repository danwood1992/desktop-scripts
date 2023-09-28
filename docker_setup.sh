#!/bin/bash

# Author: Daniel Wood 
# Last Updated: 28-09-23
# This script is designed to handle docker installations on Ubuntu
# Always test the script in a dev/test env before running it in prod

set -e 

DOCKER_GPG_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO="https://download.docker.com/linux/ubuntu"

install_packages() {
  apt-get install -y -q "$@"
}

log() {
  echo "[INFO] $1"
}

init() {
  apt-get update -q
  DEBIAN_FRONTEND=noninteractive
}

check_root() {
  [ "$EUID" -eq 0 ] || { echo "Run as root"; exit 1; }
}

check_ubuntu() {
  grep -q 'Ubuntu' /etc/os-release || { echo "Only for Ubuntu"; exit 1; }
}

check_internet() {
  wget -q --spider http://google.com || { echo "No internet"; exit 1; }
}

install_docker() {
  which curl >/dev/null || install_packages curl
  which gpg >/dev/null || install_packages gnupg
  install_packages ca-certificates curl gnupg

  curl -fsSL $DOCKER_GPG_URL | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # Add Docker APT repo
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_REPO $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update -q

  install_packages docker-ce docker-ce-cli containerd.io
}

# Main script
check_root
check_ubuntu
check_internet

log "Removing conflicting packages..."
apt-get remove -y -q docker docker-engine docker.io containerd runc

log "Installing Docker..."
install_docker

# Verify and finalize installation
docker run hello-world || { echo "Docker verification failed"; exit 1; }
getent group docker > /dev/null || groupadd docker

usermod -aG docker $USER
# newgrp docker

systemctl enable docker.service
systemctl enable containerd.service

echo "Please logout and log back in or start a new terminal session to apply docker group changes."








