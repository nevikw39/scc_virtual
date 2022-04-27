#!/bin/bash

#SBATCH -J HPL
#SBATCH -A ACD110018
#SBATCH -o hpl_output.txt
#SBATCH -e hpl_error.txt
#SBATCH -p ct56
#SBATCH -N 1
#SBATCH --ntasks-per-node=56
#SBATCH --ntasks-per-core=2
#SBATCH --hint=multithread

cd bin/Linux_PII_CBLAS/

srun -n 56 ./xhpl
