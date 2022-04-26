source env.sh

ml purge
ml cmake/3.15.4 gcc9/9.3.1 cuda/11.3 openmpi4/4.1.1 singularity fftw3/3.3.9
ml s scc_virtual_gromacs
