#!/bin/bash
#SBATCH --time=7-00:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes, KEEP AT 1 ON EULER, unless running NEB jobs
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node
#SBATCH --mem=175G   # maximum memory per node

ulimit -s unlimited

python ~/bin/vasp_raman.py > out_$(date +%m_%d_%Y_%H:%M:%S)
