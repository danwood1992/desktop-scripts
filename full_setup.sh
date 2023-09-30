#!/bin/bash

# Author: Daniel Wood (Woody)
# Last Updated: 2023-09-28
# Purpose: Install and configure development utilities and packages

LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/utils_setup.log"

source ./read-config.sh
source ./utils.sh
source ./install-packages.sh
source ./install-node.sh

set -e
set -o pipefail

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




