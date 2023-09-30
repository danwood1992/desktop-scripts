#!/bin/bash

# Author: Daniel Wood (Woody)
# Last Updated: 2023-09-28
# Purpose: To save time Installing and setup development utilities and packages


BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$BASE_DIR/read-config.sh"
source "$BASE_DIR/utils.sh"

check_root
check_ubuntu
check_internet
set -e 
# This is main.sh
function show_usage {
    echo "Usage: main.sh <command> [<args>]"
    echo "Commands:"
    echo "  docker-setup     Run docker setup"
    echo "  full-setup       Run full setup"
    echo "  git-setup        Setup git"
    echo "  install-node     Install Node.js"
    echo "  install-packages Install packages in config"
    echo "  system-info      Show system information"
}

if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

command="$1"
shift

case "$command" in
    "docker-setup")
        source docker_setup.sh "$@"
        ;;
    "full-setup")
        source setups/full_setup.sh "$@"
        ;;
    "git-setup")
        source setups/git_setup.sh "$@"
        ;;
    "install-node")
        source installs/install_node.sh "$@"
        ;;
    "install-packages")
        source installs/install_packages.sh "$@"
        ;;
    "read-config")
        source read-config.sh "$@"
        ;;
    "system-info")
        source system_info.sh "$@"
        ;;
    *)
        echo "Unknown command: $command"
        show_usage
        exit 1
        ;;
esac