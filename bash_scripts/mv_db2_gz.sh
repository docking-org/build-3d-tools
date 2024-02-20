#!/bin/sh

cd /wynton/group/bks/work/isknight/2024-02-03_MEL_build_3D/final_output/$SGE_TASK_ID
for f in *.db2.gz ; do mv $f ${f%.gz} ; done 

