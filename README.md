# julia2rust (WIP)

An inefficient one-filer Julia to Rust transpiler.

## Documentation


### Usage:

`julia2rust file.jl`


This accepts a Julia file (currently) as input and outputs Rust file of the same name on the same directory as the input Julia file.

There must be exactly one `main` Julia function which will be translated to `main` function in the generated rust file which serves as the entry point of every Rust program.

Note that this does not currently work with `cargo`.

### Install

`git clone https://github.com/Jdf2023/julia2rust/tree/main`

`cd julia2rust`

`nimble build` for debug build

`nimble build -d:release` for release build

## Roadmap

 - [x] `function`
 - [x] `for in` loop
 - [x] `if` statement
 - [x] `=` Assignment
 - [ ] All others
 - [ ] Support for multiple communicating files.