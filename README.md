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
