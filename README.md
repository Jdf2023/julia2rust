# julia2rust (WIP)

An inefficient one-filer Julia to Rust transpiler.

## Documentation


#### Usage:

    julia2rust file.jl

#### Key points for the time being

* There must be exactly one `main` function in the Julia file to be translated to one `main` function which will serve as the entry point of the generated Rust file.

* `for =` loop does not work and will never be supported in the distant future. Use `for in` loop instead.

#### Install

##### Download
    git clone https://github.com/Jdf2023/julia2rust

##### Go inside the directory
    cd julia2rust

##### Build in debug mode
    nimble build

##### Build in release mode
    nimble build -d:release

## Roadmap

 - [x] `function`
 - [x] `for in` loop
 - [x] `if elseif else` statement
 - [x] `=` Variable assignment
 - [ ] All other Julia constructs
 - [ ] Support for multiple communicating files.