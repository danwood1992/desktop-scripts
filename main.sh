#!/bin/bash

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
        source full_setup.sh "$@"
        ;;
    "git-setup")
        source git_setup.sh "$@"
        ;;
    "install-node")
        source install_node.sh "$@"
        ;;
    "install-packages")
        source install_packages.sh "$@"
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