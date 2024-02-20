#!/bin/sh

build_3d_tarball_dirs=/wynton/group/bks/work/isknight/2024-02-08_build_second_round_synthon_docking/data/batch_3d_tarball_dirs
dir_with_tarballs=$(head -$SGE_TASK_ID $build_3d_tarball_dirs | tail -1)

echo $dir_with_tarballs

cd $dir_with_tarballs
echo "Starting..."
for f in *.tar.gz ; do tar -xzf $f ; done
echo "Finished."

