#!/bin/sh

cd /wynton/group/bks/work/isknight/2024-02-08_build_second_round_synthon_docking/data/final_output
#cd /wynton/group/bks/work/isknight/2024-02-03_MEL_build_3D/final_output/
#for f in *.db2.gz ; do mv $f ${f%.gz} ; done 

tar -czf $SGE_TASK_ID.db2.tgz $SGE_TASK_ID

