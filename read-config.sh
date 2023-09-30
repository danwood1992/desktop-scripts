#!/bin/bash

CONFIG_FILE="config.json"

if [ -f "$CONFIG_FILE" ]; then
  # Read the node_version
  NODE_VERSION=$(jq -r '.node_version' "$CONFIG_FILE")

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

# Now you can use NODE_VERSION and PACKAGE_LIST as needed
echo "Node Version: $NODE_VERSION"
echo "Packages:"
for PACKAGE in "${PACKAGE_LIST[@]}"; do
  echo "$PACKAGE"
done