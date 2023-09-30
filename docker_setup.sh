#!/bin/bash

LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/docker_setup.log"

source "$BASE_DIR/installs/install_packages.sh"

setup_logging


init() {
  apt-get update -q
  DEBIAN_FRONTEND=noninteractive
}



install_docker() {

  echo "Installing Docker packages..."
  for package in "${DOCKER_PACKAGES[@]}"; do
    echo "Installing $package..."
    
  done
  sudo apt-get install ca-certificates curl gnupg
  install_packages $DOCKER_PACKAGES

  curl -fsSL $DOCKER_GPG_URL | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # Add Docker APT repo
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_REPO $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update -q

  
}


# main

log_entry "Removing conflicting packages..."

if apt-get remove -y -q docker docker-engine docker.io containerd runc; then
  echo "Removed conflicting packages"
else
  echo "No conflicting packages found"
fi

install_docker

# Verify and finalize installation
docker run hello-world || { echo "Docker verification failed"; exit 1; }
getent group docker > /dev/null || groupadd docker

usermod -aG docker $USER
# newgrp docker

systemctl enable docker.service
systemctl enable containerd.service

echo "Please logout and log back in or start a new terminal session to apply docker group changes."








