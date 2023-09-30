#!/bin/bash
source ./read-config.sh

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

echo "Git configuration has been set up with the following values:"
echo "Email: $EMAIL"
echo "Name: $NAME"
