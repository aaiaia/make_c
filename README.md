# version 1
Make a library and applications. Example of file tree is below.

## file tree
### library source
```console
./lib/
./lib/src/[DIR or FILE]
./lib/include/[DIR or FILE]
```

### library output
```console
./out/debug/lib/libbasic.so.1.0
./out/debug/lib/libbasic.a
./out/debug/lib/libbasic.so
```

### applications source
```console
./app/
./app/[FILE 1]
./app/[FILE 2]
./app/[DIR 1]/[FILE 3]
./app/[DIR 1]/[FILE 4]
./app/[DIR 2]/[FILE 5]
```

### applications output
```console
./out/debug/app/
./out/debug/app/[FILE 1]
./out/debug/app/[FILE 2]
./out/debug/app/[DIR 1]/[FILE 3]
./out/debug/app/[DIR 1]/[FILE 4]
./out/debug/app/[DIR 2]/[FILE 5]
```

