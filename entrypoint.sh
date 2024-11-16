#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "==========================="

# Configure Git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Run the Python script
python3 /usr/bin/feed.py

# Stage and commit changes
git add -A
if git diff-index --quiet HEAD; then
  echo "No changes to commit"
else
  git commit -m "Update Feed"
fi

# Push changes to the main branch
git push --set-upstream origin main

echo "Feed updated successfully!"
echo "==========================="