#!/bin/bash

# Author: Daniel Wood (Woody)
# Last Updated: 2023-09-28
# Purpose: To save time Installing and setup development utilities and packages

LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/full_setup.log"

source "$BASE_DIR/installs/install_packages.sh"
source "$BASE_DIR/installs/install_node.sh"
source "$BASE_DIR/system_info.sh"

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




