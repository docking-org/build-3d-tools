#!/bin/sh

start=1
for d in */ ; do
    name=${d%.d/} # Removes trailing slash to match the directory name correctly with the input name
    num=$(cat "../in/$name" | wc -l)

    # Construct the glob pattern for the expected file names within this directory
    pattern="$d/2_{$start..$(($start + $num))}.0.*.db2.gz"

    # Use find to locate files matching the pattern and extract the matching part
    find $d -type f -name "2_*.0.*.db2.gz" | while read filepath; do
        # Extract the index from the filename
        if [[ $filepath =~ 2_([0-9]+)\.0.*\.db2\.gz ]]; then
            index=${BASH_REMATCH[1]}
            # Ensure the index falls within the expected range
            if (( index >= start && index <= start + num )); then
                realpath $filepath
            fi
        fi
    done

    start=$(($start + $num))
done

