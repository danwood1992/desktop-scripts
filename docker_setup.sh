#!/bin/bash

LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/docker_setup.log"

source "$BASE_DIR/installs/install_packages.sh"

echo "Docekr GPG URL  $DOCKER_GPG_URL"

echo "Docker Repo URL $DOCKER_REPO"



