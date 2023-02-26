#!/bin/bash

# Set the directory to compress to the first command line argument, or the current directory if not provided
dir="${1:-.}"

# Loop through each file in the directory
for file in "$dir"/*
do
    # Check if the file is a regular file and not a directory
    if [ -f "$file" ]; then
        # Compress the file using gzip
        gzip "$file"
    fi
done
