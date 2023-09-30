source ./read-config.sh

install_packages() {
  local packages=("$@")
  for package in "${packages[@]}"; do
    if dpkg -l | grep -qw "$package"; then
      log_entry "Upgrading $package..."
      DEBIAN_FRONTEND=noninteractive apt-get install --only-upgrade -y "$package" || { log_entry "Failed to upgrade $package"; exit 1; }
    else
      log_entry "Installing $package..."
      DEBIAN_FRONTEND=noninteractive apt-get install -y "$package" || { log_entry "Failed to install $package"; exit 1; }
    fi
  done
}