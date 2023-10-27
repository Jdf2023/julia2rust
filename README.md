# julia2rust (WIP)

An inefficient one-filer Julia to Rust transpiler.

## Documentation


#### Usage:

    julia2rust file.jl


This accepts a Julia file (currently) as input and outputs Rust file of the same name on the same directory as the input Julia file.

There must be exactly one `main` Julia function which will be translated to `main` function in the generated Rust file which serves as the entry point of every Rust program.

Note that, for the time being, all variables in the generated Rust file are mutable by default due to the nature of Julia.

Note also that this does not currently work with `cargo`.

#### Install

##### Download
    git clone https://github.com/Jdf2023/julia2rust/tree/main

##### Go inside the directory
    cd julia2rust

##### Build in debug mode
    nimble build

##### Build in release mode
    nimble build -d:release

## Roadmap

 - [x] `function`
 - [x] `for in` loop
 - [x] `if` statement
 - [x] `=` Variable assignment
 - [ ] All other Julia constructs
 - [ ] Support for multiple communicating files.