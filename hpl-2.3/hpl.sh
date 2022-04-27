#!/bin/bash

#SBATCH -J HPL
#SBATCH -A ACD110018
#SBATCH -o hpl_output.txt
#SBATCH -e hpl_error.txt
#SBATCH -p ct224
#SBATCH -n 112
#SBATCH --ntasks-per-core=2
#SBATCH --hint=multithread

cd bin/Linux_PII_CBLAS/

srun -n 112 ./xhpl
