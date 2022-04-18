export APPROOT=~/scc_virtual
export MODULEPATH=$APPROOT/modules:$MODULEPATH
export ZLIB=$APPROOT/opt/zlib-1.2.11

alias mpiexec=srun
alias mpirun=srun

ml load compiler/gcc/7.5.0 mpich-3.1.4-t zlib-1.2.11-t
