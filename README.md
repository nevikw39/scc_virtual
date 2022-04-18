# SCC Virtual Contest

## Commit Policy

- [.gitignore](https://github.com/nevikw39/scc_virtual/blob/master/.gitignore)
    - Ignore all file downloaded or cloned
    - Unignore everything modified (may need `git add --force`)
- Write all commands into `README.md`
- Update directory structure in `README.md`

## Environments

```bash
source env.sh
```

## Directory Structure

- build
- opt
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
