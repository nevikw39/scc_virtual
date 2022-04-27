#!/bin/bash

#SBATCH -J GROMACS_Singularity
#SBATCH -A ACD110018
#SBATCH -N 1
#SBATCH -o gromacs_singularity_output.txt
#SBATCH -e gromacs_singularity_error.txt
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=4

ml singularity

export GPU_COUNT=1
export OMP_NUM_THREADS=1

cd $APPROOT/gromacs/water-cut1.0_GMX50_bare/1536

srun singularity run --nv -B ${PWD}:/mnt/host_pwd --pwd /mnt/host_pwd $APPROOT/gromacs/gromacs_2021.3.sif gmx grompp -f pme.mdp
srun singularity run --nv -B ${PWD}:/mnt/host_pwd --pwd /mnt/host_pwd $APPROOT/gromacs/gromacs_2021.3.sif gmx mdrun -ntmpi ${GPU_COUNT} -nb gpu -ntomp ${OMP_NUM_THREADS} -pin on -v -noconfout -nsteps 5000 -s topol.tpr
