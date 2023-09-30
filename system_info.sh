#!/bin/bash

for PACKAGE in "${PACKAGE_LIST[@]}"; do
    INSTALLED_VERSION=$(dpkg-query -W -f='${Version}' "$PACKAGE" 2>/dev/null)
    if [ -z "$INSTALLED_VERSION" ]; then
        INSTALLED_VERSION="Not installed"
    fi
    echo "$PACKAGE: $INSTALLED_VERSION"
done

