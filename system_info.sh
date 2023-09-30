#!/bin/bash
source ./read-config.sh


# Loop through the packages and check their versions
for PACKAGE in "${PACKAGE_LIST[@]}"; do
    INSTALLED_VERSION=$(dpkg-query -W -f='${Version}' "$PACKAGE" 2>/dev/null)
    if [ -z "$INSTALLED_VERSION" ]; then
        INSTALLED_VERSION="Not installed"
    fi
    echo "$PACKAGE: $INSTALLED_VERSION"
done

