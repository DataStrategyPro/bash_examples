#!/bin/bash

# Set the directory to compress to the first command line argument, or the current directory if not provided
dir="${1:-.}"

# Loop through each file in the folder
for file in "$dir"/*
do
    # Check if the file is a regular file (not a directory)
    if [ -f "$file" ]
    then
        # Extract the footer record from the file
        footer=$(zcat "$file" | tail -z -n 1)
        
        # Extract the expected number of records from the footer record
        expected_records=$(echo "$footer" | cut -d '|' -f 2)
        
        # Count the number of records in the file (excluding the header and footer rows)
        actual_records=$(($(zcat "$file" | wc -z -l | cut -d ' ' -f 1) - 2))
        
        # Compare the actual and expected number of records
        if [ "$actual_records" -eq "$expected_records" ]
        then
            echo "File $file has the correct number of records: $actual_records"
        else
            echo "File $file has an incorrect number of records: $actual_records (expected: $expected_records)"
        fi
    fi
done
