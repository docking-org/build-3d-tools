#!/bin/bash

# Path to the text file containing filepaths
FILEPATHS_FILE=$1

# Initialize variables
dir=1
count=0

# Create the first directory
mkdir -p "$dir"

# Read each line (filepath) from the file
while IFS= read -r filepath; do
	# Copy the file to the current directory
	filename=$(basename $filepath)
	cp "$filepath" $dir/${filename%.gz}
	      
	# Increment the count
	((count++))
		  
	# 
	if [ "$count" -eq 5000 ]; then
		# Reset count, increment directory
		count=0
		((dir++))
		# Create the next directory
		mkdir -p "$dir"
	fi
done < "$FILEPATHS_FILE"

