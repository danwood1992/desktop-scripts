#!/bin/bash

# Author: Daniel Wood (Woody)
# Last Updated: 2023-09-28
# Purpose: Install and configure development utilities and packages

LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/utils_setup.log"

source ./read-config.sh

source ./utils.sh

echo "packagelist: $PACKAGE_LIST"

install_node() {

  echo "Installing Node.js and NPM...$NODE_MAJOR"
  log_entry "Uninstalling Node.js and NPM..."

  apt-get purge nodejs* &&\
  rm -r /etc/apt/sources.list.d/nodesource.list &&\
  rm -r /etc/apt/keyrings/nodesource.gpg
 
  log_entry "Installing Node.js and NPM..."

  sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt-get update && sudo apt-get install nodejs -y


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
install_node

apt --fix-broken install
log_entry "Installation of development utilities completed."




