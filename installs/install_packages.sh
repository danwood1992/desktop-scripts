#!/bin/bash
source ./read-config.sh
source ./utils.sh
check_root
LOG_DIR="/var/log/my_dev_setup/packages"
LOG_FILE="$LOG_DIR/install_packages.log"

setup_logging

install_packages() {
  local packages=("$@")
  echo "Installing packages..."
  echo "Packages: ${packages[@]}" 
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

# Call the install_packages function with the PACKAGE_LIST from read-config.sh
install_packages "${PACKAGE_LIST[@]}"