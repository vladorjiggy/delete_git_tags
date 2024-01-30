#!/bin/bash

# Check if the script is in a Git repository
if [ ! -d ".git" ]; then
  echo "Error: This script must be executed in a Git repository."
  exit 1
fi

prefix="test-"

# Find tags with the specified prefix
tagsToDelete=$(git tag -l "$prefix*")

# Check if tags were found
if [ -z "$tagsToDelete" ]; then
  echo "No matching tags found."
  exit 1
fi

# Display the tags to be deleted
echo "The following tags will be deleted:"
for tag in $tagsToDelete; do
    echo $tag
done

# Ask for confirmation
read -p "Do you really want to delete these tags? (y/n): " confirm

if [ "$confirm" == "y" ]; then
    # Iterate over the found tags and delete them
    for tag in $tagsToDelete; do
        git tag -d $tag
        git push origin :refs/tags/$tag
        echo "Tag $tag has been deleted."
    done
    echo "All selected tags have been deleted."
else
    echo "Deletion operation canceled. No tags were deleted."
fi