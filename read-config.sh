#!/bin/bash

CONFIG_FILE="config.json"

if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Installing..."
  sudo apt update
  sudo apt install -y jq
fi



if [ -f "$CONFIG_FILE" ]; then
  # Read the node_version
  NODE_MAJOR=$(jq -r '.node_major' "$CONFIG_FILE")

  # Read all packages into an array
  NETWORKING_PACKAGES=($(jq -r '.networking_packages[]' "$CONFIG_FILE"))
  SYSTEM_PACKAGES=($(jq -r '.system_packages[]' "$CONFIG_FILE"))
  UTILITY_PACKAGES=($(jq -r '.utility_packages[]' "$CONFIG_FILE"))
  OPTIONAL_PACKAGES=($(jq -r '.optional_packages[]' "$CONFIG_FILE"))

  # Combine all package arrays into a single PACKAGE_LIST
  PACKAGE_LIST=("${NETWORKING_PACKAGES[@]}" "${SYSTEM_PACKAGES[@]}" "${UTILITY_PACKAGES[@]}" "${OPTIONAL_PACKAGES[@]}")

 

else
  echo "Configuration file not found: $CONFIG_FILE"
  exit 1
fi

