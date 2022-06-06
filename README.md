# lib
## COMPILE
### make options
```bash
make all
make lib
make app
make clean
```

### select static or shared library
```bash
make IS_SHARED=0 app
make IS_SHARED=1 app
```

### configure bash environments
```bash
export LD_LIBRARY='[GIT_ABSOLUTE_ROOT_PATH]/[LIBRARY_PATH]':$LD_LIBRARY
```

