source env.sh

export ZLIB=$APPROOT/opt/zlib-1.2.11
export HDF5=$APPROOT/opt/hdf5-1.8.21
export PNETCDF=$APPROOT/opt/pnetcdf-1.12.0
export NETCDF4=1
export NETCDF=$APPROOT/opt/netcdf
export PATH=$APPROOT/opt/netcdf/bin:$PATH

ml purge
ml compiler/gcc/7.5.0 mpich-3.1.4-t zlib-1.2.11-t hdf5-1.8.21-t pnetcdf-1.12.0-t netcdf-c-4.7.3-t netcdf-fortran-4.4.5-t
ml s scc_virtual_wrf
