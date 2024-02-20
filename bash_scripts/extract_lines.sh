#!/bin/bash

# Check if exactly two arguments are given (file with line numbers and file to extract from)
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <file_with_line_numbers> <file_to_extract_from> <output_file>"
    exit 1
fi

# Assign arguments to variables for better readability
file_with_numbers="$1"
file_to_extract_from="$2"
output_file="$3"

# Prepare the output file by clearing it or creating it if it doesn't exist
> "$output_file"

# Current line counter
current_line=0

# Read the file line by line
while IFS= read -r line_number; do
	# Use awk to directly extract the line and append to the output file
        awk -v line_num="$line_number" 'NR==line_num {print; exit}' "$file_to_extract_from" >> "$output_file"
done < "$file_with_numbers"

echo "Extraction complete. Check '$output_file' for the output."

