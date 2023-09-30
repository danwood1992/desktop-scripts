#!/bin/bash

check_root
LOG_DIR="/var/log/my_dev_setup/packages"
LOG_FILE="$LOG_DIR/install_packages.log"

setup_logging

log_entry "updating git config"
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
log_entry "git config updated"

echo "Git configuration has been set up with the following values:"
echo "Email: $GIT_EMAIL"
echo "Name: $GIT_NAME"

log_entry "Email Changed to: $GIT_EMAIL"
log_entry "Name changed to: $GIT_NAME"