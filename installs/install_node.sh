#!/bin/bash

check_root
LOG_DIR="/var/log/my_dev_setup/node"
LOG_FILE="$LOG_DIR/node_setup.log"

setup_logging

install_node() {

  log_entry "Checking Node.js version..."
  
  # Check if node is installed and if the installed version matches the desired major version
  if command -v node > /dev/null && [[ "$(node -v | cut -d '.' -f 1)" == "v$NODE_MAJOR" ]]; then
    log_entry "Node.js major version $NODE_MAJOR is already installed."
    return 0
  fi
  

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

install_node