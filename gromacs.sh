#!/bin/bash

#SBATCH -J GROMACS
#SBATCH -A ACD110018
#SBATCH -N 1
#SBATCH -o gromacs_output.txt
#SBATCH -e gromacs_error.txt
#SBATCH --cpus-per-task 4
#SBATCH --gres=gpu:1

source env_gromacs.sh

ml r scc_virtual_gromacs

source $APPROOT/opt/gromacs/bin/GMXRC.bash

export OMP_NUM_THREADS=4

srun --mpi=pmi2 --accel-bind=g --ntasks=$SLURM_NTASKS gmx_mpi mdrun -s stmv.tpr -v -noconfout -maxh 0.1 -resethway -nsteps 5000 -nb gpu -ntomp 4
