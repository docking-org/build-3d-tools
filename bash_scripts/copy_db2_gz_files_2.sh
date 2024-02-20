#!/bin/bash
#$ -cwd
#$ -N copy_files

FILEPATHS_FILE=/wynton/group/bks/work/isknight/2024-02-08_build_second_round_synthon_docking/data/output/expanded.smi.batch-3d.d/finished_molecule_filepaths

# Calculate line numbers for slicing the filepaths.txt
START=$(( (${SGE_TASK_ID} - 1) * 5000 + 1 ))
END=$(( ${SGE_TASK_ID} * 5000 ))

# Create a subdirectory for this range of lines
SUBDIR=${SGE_TASK_ID}
mkdir -p "${SUBDIR}"

# Slice filepaths.txt and copy files to the respective subdirectory
sed -n "${START},${END}p" $FILEPATHS_FILE | while read FILEPATH; do
  filename=$(basename $FILEPATH)
  cp $FILEPATH $SUBDIR/${filename%.gz}
done

