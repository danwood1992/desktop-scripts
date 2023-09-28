#!/bin/bash

# Author: Daniel Wood (Woody)
# Last Updated: 2023-09-28

# Configuration
LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/utils_setup.log"
NODEJS_SETUP_URL="https://deb.nodesource.com/setup_18.x"
PACKAGE_LIST="curl wget git vim htop net-tools build-essential python3 python3-pip python3-venv"

# Setup logging directory and file with appropriate permissions

check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Run as root" >&2
    exit 1
  fi
}


setup_logging() {
  mkdir -p "$LOG_DIR"
  chmod 700 "$LOG_DIR"

  touch "$LOG_FILE"
  chmod 600 "$LOG_FILE"
}

handle_error() {
  log_entry "Error on line $1"
  exit 1
}


log_entry() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

install_packages() {
  for package in "$@" ; do
    if ! dpkg -l | grep -qw "$package"; then
      log_entry "Installing $package..."
      DEBIAN_FRONTEND=noninteractive apt install -y "$package" || { log_entry "Failed to install $package"; exit 1; }
    else
      log_entry "$package is already installed, skipping..."
    fi
  done
}

check_ubuntu() {
  log_entry "Checking OS..."
  grep -q 'Ubuntu' /etc/os-release || { log_entry "Only for Ubuntu"; exit 1; }
}

check_internet() {
  log_entry "Checking internet connection..."
  wget -q --spider http://google.com || { log_entry "No internet"; exit 1; }
}

# Update and upgrade Ubuntu packages
update_packages() {
  log_entry "Updating package list and upgrading existing packages..."
  apt update -y && apt upgrade -y
}

# Install Node.js, NPM, Yarn and TypeScript
install_nodejs() {
  log_entry "Installing Node.js and NPM..."
  curl -fsSL $NODEJS_SETUP_URL | sudo -E bash -
  install_packages "nodejs"

  log_entry "Installing Yarn..."
  npm install --global yarn

  log_entry "Installing TypeScript..."
  npm install -g typescript
}

# ---- Main Script ----

# Exit on any command failure and enable debugging
set -e
set -o pipefail

# Main script

check_root
setup_logging
trap 'handle_error $LINENO' ERR
check_ubuntu
check_internet
update_packages
install_packages $PACKAGE_LIST
install_nodejs

log_entry "Installation of development utilities completed."




