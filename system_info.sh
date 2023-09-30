#!/bin/bash

# Define the path to your configuration file
CONFIG_FILE="config.json"

# Read the package names from the configuration file
PACKAGES=($(jq -r '.networking_packages + .system_packages + .utility_packages + .optional_packages | join(" ")' "$CONFIG_FILE"))

# Loop through the packages and check their versions
for PACKAGE in "${PACKAGES[@]}"; do
    INSTALLED_VERSION=$(dpkg-query -W -f='${Version}' "$PACKAGE" 2>/dev/null)
    if [ -z "$INSTALLED_VERSION" ]; then
        INSTALLED_VERSION="Not installed"
    fi
    echo "$PACKAGE: $INSTALLED_VERSION"
done

