#!/bin/bash

# Set your email and name here
read -p "Enter your email: " EMAIL

read -p "Enter your name: " NAME


git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

echo "Git configuration has been set up with the following values:"
echo "Email: $EMAIL"
echo "Name: $NAME"
