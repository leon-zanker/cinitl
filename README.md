# cinitl

`cinitl` is a simple initialization tool for small multi-file C library projects. It is currently tested both on Linux and macOS.

For an executable initialization tool similar to `cinitl` see [cinit](https://github.com/leon-zanker/cinit).

This application is meant to work well with `clang`, `clangd` and `lldb`, as it has functionality specifically for `clangd` and the default `Makefile` uses `clang` as the compiler and `lldb` as the debugger, though you can easily switch out the `COMPILER` variable, with that being the only change necessary to use another compiler of your choice and the `DEBUGGER` variable, with that being the only change necessary to use another debugger of your choice.

## Features

`cinitl` will initialize the following project structure ("project" will be the name for your project):

``` shell
$ cinitl project
# initialization output
$ cd project
$ tree
.
├── LICENSE.txt
├── Makefile
├── README.md
├── build
├── doc
├── examples
├── include
│   └── project.h
├── lib
├── src
├── target
└── test
    └── test.c
```

The `Makefile` supports that the `src` directory can contain multiple C source files, as long as they are not located inside subfolders. The same is true for the `include` folder and header files, respectively. You can also specify multiple, space-separated packages/dependencies/libraries that should be looked up using `pkg-config` during the compilation process. If you need intellisense from `clangd` for these packages/dependencies/libraries you can run the `make commands` command to generate a `compile_commands.json` file for it using `bear`. You can also use static libraries locally in your project by placing them in the `lib` directory and their respective header files in the `include` directory (please note that the libraries must follow the default C library naming convention, that is "lib{library name}.a", where {library name} is replaced with the name of the library).

The possible `Makefile` commands are:

- `make`: This builds the `.a` library in the target directory using the variables specified in the `Makefile` and copies the header file with the same name as the project to the target directory.
- `make run`: This runs ./test/test (use `make test` to build the test)
- `make debug`: This runs the debugger specified in the `Makefile` on the test. The default debugger is `lldb`.
- `make clean`: This will delete everything inside `target`, `build` and `test` as well as the whole `.cache` directory, should it exist.
- `make commands`: This will create a `compile_commands.json` file using `bear` (this enables intellisense with clangd when using third party dependencies). `bear` has to be installed seperately for this to work.

`cinitl` will also initialize an MIT License and a template for a README file (please don't forget to enter your name instead of [your name]).

It will also initialize a simple header file with `#pragma once` that has the same name as the project.

NOTES: Before generating/regenerating the `compile_commands.json` file with `make commands`, please run `make clean`, so `bear` can catch all dependencies correctly. Also, `pkg-config` will output an error telling you to specify package names when the `PACKAGES` variable in the `Makefile` is empty. This does not impact the compilation of programs that don't use third party dependencies, so it is completely safe to leave the `PACKAGES` variable empty.

## Installation

To install and use `cinitl` you will need the following:

- `make`
- `pkg-config`
- A C compiler - the default is `clang`, but you can specify another one such as `gcc` with the `CC` variable in the `Makefile`
- `lldb` or another debugger (only if you plan on using the `make debug` command)
- `bear` (only if you need to generate `compile_commands.json` files)

To install `cinitl`, clone the repository to a location of your choice, `cd` into the directory and run the following commands to compile and create a symbolic link to the executable. Switch out "location/in/your/path" for the directory you want to put the symbolic link in:

```shell
$ make
$ sudo ln -s "$(pwd)/cinitl" "location/in/your/path/cinitl"
```

A common place to put symbolic links to programs on Linux is "/usr/local/bin", though you may put it in any directory in your PATH or use another method of making it available globally.

Copyright (C) 2024 Leon Zanker
