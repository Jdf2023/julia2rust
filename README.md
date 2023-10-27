# julia2rust (WIP)

An inefficient one-filer Julia to Rust transpiler.

## Documentation

Usage:
    julia2rust <file.jl>

This accepts a file `file.jl` and outputs a file named `file.rs` to the same directory where the `file.jl` resides. The generated `file.rs` can then be fed to the Rust compiler, `rustc`, for compilation.

Note that currently, this does not work with `cargo`.

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