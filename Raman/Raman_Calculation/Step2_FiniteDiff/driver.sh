#!/bin/bash

#SBATCH --time=0-01:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes, KEEP AT 1 ON EULER, unless running NEB jobs
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node
#SBATCH --mem=175G   # maximum memory per node

ulimit -s unlimited
vasptype='vasp-ncl'
rm out*
outfile=out_$(date +%Y_%m_%d_%H:%M:%S)

echo $HOSTNAME > a
date >> a
mpirun -n 16 /opt/bin/$vasptype > $outfile


date >> a

mkdir ToDownload

cp CONTCAR ToDownload/.
cp INCAR ToDownload/.
cp out* ToDownload/.
