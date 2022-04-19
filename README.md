# SCC Virtual Contest

## Commit Policy

Create a [GitHub Token](https://github.com/settings/tokens) and clone this repo like:
```bash
git clone https://<username>:<token>@github.com/nevikw39/scc_virtual.git
```

- [.gitignore](https://github.com/nevikw39/scc_virtual/blob/master/.gitignore)
    - Ignore all file downloaded or cloned
    - Unignore everything modified (may need `git add --force`)
- Write all commands into `README.md`
- Update directory structure in `README.md`

## Environments

Each time open a new shell:
```bash
source env.sh
```

## Directory Structure

- modules
- build
  - mpich-3.1.4
  - zlib-1.2.11
  - hdf5-1.8.21
  - pnetcdf-1.12.0
  - netcdf-c-4.7.3
  - netcdf-fortran-4.4.5
- opt
  - mpich-3.1.4
  - zlib-1.2.11
  - hdf5-1.8.21
  - pnetcdf-1.12.0
  - netcdf-c-4.7.3
  - netcdf-fortran-4.4.5
- env.sh

## WRF

### Modules

```bash
git clone https://github.com/William-Mou/module_file.git
mv module_file/modules modules
rm -rf module_file
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/modules/*
```

### MPICH

```bash
cd $APPROOT/build
wget http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz --no-check-certificate
tar zxvf mpich-3.1.4.tar.gz
cd mpich-3.1.4
CC=gcc CXX=g++ FC=gfortran ./configure --prefix=$APPROOT/opt/mpich-3.1.4 --with-pm=none --with-pmi=slurm
make -j 56 install
# make check
ml load mpich-3.1.4-t
```

### zlib

```bash
cd $APPROOT/build
wget https://zlib.net/fossils/zlib-1.2.11.tar.gz
tar zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
CC=gcc CXX=g++ FC=gfortran ./configure --prefix=$APPROOT/opt/zlib-1.2.11
make -j 56 install
# make check
ml load zlib-1.2.11-t
```

### HDF5

```bash
cd $APPROOT/build
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.bz2
tar xvf hdf5-1.8.21.tar.bz2
cd hdf5-1.8.21
CC=mpicc CXX=mpicxx F77=mpifort F90=mpif90 F9X=mpif90 FC=mpif90 ./configure --enable-parallel --enable-fortran --enable-hl --prefix=$APPROOT/opt/hdf5-1.8.21 --disable-shared --with-zlib=$APPROOT/opt/zlib-1.2.11
make install # -j 56
# sed -i "s|mpiexec|srun|g" . && make check
ml load hdf5-1.8.21-t
```

### pNetCDF

```bash
cd $APPROOT/build
wget https://parallel-netcdf.github.io/Release/pnetcdf-1.12.0.tar.gz
tar zxvf pnetcdf-1.12.0.tar.gz
cd pnetcdf-1.12.0
CC=mpicc CXX=mpicxx ./configure MPICC=mpicc MPICXX=mpicxx MPIF77=mpif77 MPIF90=mpif90 --prefix=$APPROOT/opt/pnetcdf-1.12.0
make install # -j 56
# make check
ml load pnetcdf-1.12.0-t
```

### NetCDF-C

```bash
cd $APPROOT/build
wget https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.7.3.tar.gz
tar zxvf v4.7.3.tar.gz
cd netcdf-c-4.7.3
CC=mpicc CXX=mpicxx CPPFLAGS="-I$APPROOT/opt/hdf5-1.8.21/include -I$APPROOT/opt/pnetcdf-1.12.0/include" LDFLAGS="-L$APPROOT/opt/hdf5-1.8.21/lib -L$APPROOT/opt/pnetcdf-1.12.0/lib" LIBS="-ldl -lm -lz -lhdf5 -lhdf5_hl -lhdf5_fortran -lhdf5hl_fortran -lpnetcdf" ./configure --enable-pnetcdf --enable-netcdf4 --disable-dap --disable-shared --prefix=$APPROOT/opt/netcdf-c-4.7.3 
make -j 56 install
# sed -i "s|mpiexec|srun|g" nc_test/run_pnetcdf_test.sh && make check
ml load netcdf-c-4.7.3-t
```

### NetCDF-Fortran

```bash
cd $APPROOT/build
wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.5.tar.gz
tar zxvf v4.4.5.tar.gz
cd netcdf-fortran-4.4.5
CC=mpicc CXX=mpicxx FC=mpif90 CPPFLAGS="-I$APPROOT/opt/hdf5-1.8.21/include -I$APPROOT/opt/pnetcdf-1.12.0/include -I$APPROOT/opt/netcdf-c-4.7.3/include" LDFLAGS="-L$APPROOT/opt/hdf5-1.8.21/lib -L$APPROOT/opt/pnetcdf-1.12.0/lib -L$APPROOT/opt/netcdf-c-4.7.3/lib" LIBS="-ldl -lm -lz -lhdf5 -lhdf5_hl -lhdf5_fortran -lhdf5hl_fortran -lpnetcdf -lnetcdf" ./configure --disable-shared --prefix=$APPROOT/opt/netcdf-fortran-4.4.5
make install # -j 56
# make check
ml load netcdf-fortran-4.4.5-t
```

### WRF

First put `netcdf-c` and `netcdf-fortran` together:
```bash
mkdir $APPROOT/opt/netcdf
mkdir $APPROOT/opt/netcdf/bin $APPROOT/opt/netcdf/include $APPROOT/opt/netcdf/lib
ln -s $APPROOT/opt/netcdf-c-4.7.3/bin/* $APPROOT/opt/netcdf/bin
ln -s $APPROOT/opt/netcdf-fortran-4.4.5/bin/* $APPROOT/opt/netcdf/bin
ln -s $APPROOT/opt/netcdf-c-4.7.3/include/* $APPROOT/opt/netcdf/include
ln -s $APPROOT/opt/netcdf-fortran-4.4.5/include/* $APPROOT/opt/netcdf/include
ln -s $APPROOT/opt/netcdf-c-4.7.3/lib/* $APPROOT/opt/netcdf/lib
ln -s $APPROOT/opt/netcdf-fortran-4.4.5/lib/* $APPROOT/opt/netcdf/lib
```
There would be some error since there is `pkgconfig` in both `netcdf-c` and `netcdf-fortran`.

```bash
cd $APPROOT/build
git clone https://github.com/wrf-model/WRF
cd WRF
git checkout tags/ISC21 -b ISC21-branch
./configure # choose 35
# vim configure.wrf
./compile -j 6 em_real >& build_wrf.log
```
