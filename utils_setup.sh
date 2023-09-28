#!/bin/bash

# Author: Daniel Wood 
# Last Updated: 28-09-23
# NOTE: Run this script as root or with sudo.

LOG_FILE="./logs/utils_setup.log"

function check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
  fi
}

function update_packages() {
  echo "Updating package list and upgrading existing packages..." | tee -a $LOG_FILE
  apt update -y && apt upgrade -y
}

function install_basic_utils() {
  echo "Installing basic utilities..." | tee -a $LOG_FILE
  apt install -y curl wget unzip zip net-tools git build-essential python3 python3-pip
}

function install_nodejs() {
  echo "Installing Node.js and NPM..." | tee -a $LOG_FILE
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  apt install -y nodejs
}

function install_yarn() {
  echo "Installing Yarn..." | tee -a $LOG_FILE
  npm install --global yarn
}

function install_graphql() {
  echo "Installing GraphQL utilities..." | tee -a $LOG_FILE
  npm install -g graphql-cli
}

function install_typescript() {
  echo "Installing TypeScript..." | tee -a $LOG_FILE
  npm install -g typescript
}

function cleanup() {
  echo "Cleaning up..." | tee -a $LOG_FILE
  apt autoremove -y && apt clean
}

function display_versions() {
  echo "Installed versions:" | tee -a $LOG_FILE
  git --version | tee -a $LOG_FILE
  python3 --version | tee -a $LOG_FILE
  pip3 --version | tee -a $LOG_FILE
  node --version | tee -a $LOG_FILE
  npm --version | tee -a $LOG_FILE
  yarn --version | tee -a $LOG_FILE
}

# Main Script
check_root
update_packages
install_basic_utils
install_nodejs
install_yarn
install_graphql
install_typescript
cleanup
display_versions

echo "Installation of development utilities completed." | tee -a $LOG_FILE


