#!/bin/bash

# Check if a commit message is provided as an argument
if [ -z "$1" ]; then
  echo "Error: Commit message is required."
  echo "Usage: ./commit_push.sh \"Your commit message\""
  exit 1
fi

# Add all local files to the staging area
git add .

# Commit changes with the provided message
git commit -m "$1"

# Push changes to the 'main' branch
git push origin main

