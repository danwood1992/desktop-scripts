source ./read-config.sh

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