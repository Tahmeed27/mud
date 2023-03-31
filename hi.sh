#!/bin/bash

# Loop through all files in the current directory and its subdirectories,
# excluding any files named "yarn.lock"
find . -type f ! -name yarn.lock | while read file; do
  # Search for "yarn" in the file and show the changes
  changes=$(sed 's/yarn/pnpm/g' "$file")
  if [[ "$changes" != "$(cat $file)" ]]; then
    echo "Changes to $file:"
    echo "$changes"
    # Ask for confirmation before making the changes
    read -p "Make these changes? (y/n) " choice
    if [[ "$choice" == "y" ]]; then
      # Make the changes
      sed -i 's/yarn/pnpm/g' "$file"
      echo "Changes made to $file"
    fi
  fi
done

