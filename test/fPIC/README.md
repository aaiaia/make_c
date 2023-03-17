url: https://blog.naver.com/aaiaia/223045053025
# file list
```console
$ find ./
./lib/src/test/testLib_extern.c
./lib/src/test/testLib_math.c
./lib/Makefile
./lib/include/test/testLib_extern.h
./lib/include/test/testLib_math.h
./app/test/test_math.c
./app/test/test_extern.c
```
# Make library
## static library without `-fPIC` option
```console
gcc -Ilib/include -c lib/src/test/testLib_extern.c -o testLib_extern_wo_fPIC.o
gcc -Ilib/include -c lib/src/test/testLib_math.c -o testLib_math_wo_fPIC.o
ar rcv libbasic_wo_fPIC.a testLib_extern_wo_fPIC.o testLib_math_wo_fPIC.o
ranlib libbasic_wo_fPIC.a
```

## static library with `-fPIC` option
```console
gcc -fPIC -Ilib/include -c lib/src/test/testLib_extern.c -o testLib_extern_w_fPIC.o
gcc -fPIC -Ilib/include -c lib/src/test/testLib_math.c -o testLib_math_w_fPIC.o
ar rcv libbasic_w_fPIC.a testLib_extern_w_fPIC.o testLib_math_w_fPIC.o
ranlib libbasic_w_fPIC.a
```

## shared library
```console
gcc  -fPIC -Ilib/include -c lib/src/test/testLib_extern.c -o testLib_extern_w_fPIC.o
gcc  -fPIC -Ilib/include -c lib/src/test/testLib_math.c -o testLib_math_w_fPIC.o
gcc -shared -Wl,-soname,libbasic.so -o libbasic.so.1.0 testLib_extern_w_fPIC.o testLib_math_w_fPIC.o
ln -fs libbasic.so.1.0 libbasic.so
```

# Compile apps files
## without `-fPIC` option
```console
gcc -Iapp -Ilib/include -c app/test/test_math.c -o test_math_wo_fPIC.o
gcc -Iapp -Ilib/include -c app/test/test_extern.c -o test_extern_wo_fPIC.o
```

## with `-fPIC` option
```console
gcc -fPIC -Iapp -Ilib/include -c app/test/test_math.c -o test_math_w_fPIC.o
gcc -fPIC -Iapp -Ilib/include -c app/test/test_extern.c -o test_extern_w_fPIC.o
```

# Linking with libraries
## with static lib(without `-fPIC`)
```console
gcc -o test_math_wo_fPIC test_math_wo_fPIC.o -L./ -lbasic_wo_fPIC -lm
gcc -o test_extern_wo_fPIC test_extern_wo_fPIC.o -L./ -lbasic_wo_fPIC -lm
```

## with static lib(with `-fPIC`)
```console
gcc -o test_math_w_fPIC test_math_w_fPIC.o -L./ -lbasic_w_fPIC -lm
gcc -o test_extern_w_fPIC test_extern_w_fPIC.o -L./ -lbasic_w_fPIC -lm
```

## with shared lib
```console
gcc -o test_math test_math_w_fPIC.o -L./ -lbasic -lm
gcc -o test_extern test_extern_w_fPIC.o -L./ -lbasic -lm
```

# file list
```console
$ ll
total 228
drwxrwxr-x 4 pleya pleya  4096 Mar 15 14:18 ./
drwxrwxr-x 8 pleya pleya  4096 Mar 15 12:40 ../
drwxrwxr-x 3 pleya pleya  4096 Mar 15 11:54 app/
drwxrwxr-x 4 pleya pleya  4096 Mar 15 12:40 lib/
lrwxrwxrwx 1 pleya pleya    15 Mar 15 14:18 libbasic.so -> libbasic.so.1.0*
-rwxrwxr-x 1 pleya pleya 16600 Mar 15 14:10 libbasic.so.1.0*
-rw-rw-r-- 1 pleya pleya  6046 Mar 15 14:09 libbasic_w_fPIC.a
-rw-rw-r-- 1 pleya pleya  5880 Mar 15 14:09 libbasic_wo_fPIC.a
-rwxrwxr-x 1 pleya pleya 17136 Mar 15 14:18 test_extern*
-rwxrwxr-x 1 pleya pleya 17288 Mar 15 14:16 test_extern_w_fPIC*
-rw-rw-r-- 1 pleya pleya  7184 Mar 15 14:11 test_extern_w_fPIC.o
-rwxrwxr-x 1 pleya pleya 17288 Mar 15 14:15 test_extern_wo_fPIC*
-rw-rw-r-- 1 pleya pleya  7040 Mar 15 14:11 test_extern_wo_fPIC.o
-rw-rw-r-- 1 pleya pleya  3488 Mar 15 14:10 testLib_extern_w_fPIC.o
-rw-rw-r-- 1 pleya pleya  3320 Mar 15 14:09 testLib_extern_wo_fPIC.o
-rw-rw-r-- 1 pleya pleya  2008 Mar 15 14:10 testLib_math_w_fPIC.o
-rw-rw-r-- 1 pleya pleya  2008 Mar 15 14:09 testLib_math_wo_fPIC.o
-rwxrwxr-x 1 pleya pleya 16832 Mar 15 14:18 test_math*
-rwxrwxr-x 1 pleya pleya 16944 Mar 15 14:16 test_math_w_fPIC*
-rw-rw-r-- 1 pleya pleya  2768 Mar 15 14:11 test_math_w_fPIC.o
-rwxrwxr-x 1 pleya pleya 16944 Mar 15 14:15 test_math_wo_fPIC*
-rw-rw-r-- 1 pleya pleya  2768 Mar 15 14:11 test_math_wo_fPIC.o
```
