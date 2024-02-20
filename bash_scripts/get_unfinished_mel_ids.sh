#!/bin/bash

# Initialize the start index
start=1

# Initialize the total number of lines across all files
total_lines=0

# Calculate the total number of lines (indices) expected
for name_file in ../in/*; do  # Adjusted the path to be more generic; ensure it matches your actual directory structure
    if [ -f "$name_file" ]; then  # Check if it's a file, not a directory
        # Accumulate the total lines from each file
        num_lines=$(wc -l < "$name_file")
        total_lines=$((total_lines + num_lines))
    fi
done

# Array to hold all expected indices
expected_indices=($(seq 1 $total_lines))

# Associative array to track found indices
declare -A found_indices

# Process each directory
for d in */; do
    name=${d%.d/}  # Remove the trailing slash from directory name

    # Find all matching files and extract their indices
    while IFS= read -r file; do
        if [[ $file =~ 2_([0-9]+)\.0.*\.db2.gz ]]; then
            index=${BASH_REMATCH[1]}
            found_indices[$index]=1
        fi
    done < <(find "$d" -type f -name "2_*.0.*.db2.gz")
done

# Check for missing indices
for index in "${expected_indices[@]}"; do
    if [[ -z ${found_indices[$index]} ]]; then
        echo $index
    fi
done

