import os, strutils

proc help() = echo "\nUsage:\n\tjulia2rust file.jl\n"

proc translate(juliaFile: string) =

    let contents = juliaFile.open()
    defer: contents.close()

    var fileName = juliaFile[0 .. juliaFile.len() - 4]
    fileName.add(".rs")

    var rustFile = open(fileName, fmWrite)
    defer: rustFile.close()

    for line in contents.lines():

        if line.contains("function") and line.contains("()") and "::" notin line:
            rustFile.write(line.replace("function", "fn"))
            rustFile.writeLine(" {")

        elif line.contains("function") and line.contains(")::UInt64") and "::UInt64" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (")::UInt64", ") -> u64 {\n")))
        
        elif line.contains("function") and line.contains(") :: UInt64") and " :: UInt64" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (") :: UInt64", ") -> u64 {\n")))

        elif line.contains("function") and line.contains(")::UInt32") and "::UInt32" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (")::UInt32", ") -> u32 {\n")))

        elif line.contains("function") and line.contains(") :: UInt32") and " :: UInt32" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: UInt32", ": u32"), (") :: UInt32", ") -> u32 {\n")))

        elif line.contains("function") and line.contains(")::Int64") and "::Int64" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (")::Int64", ") -> i64 {\n")))
        
        elif line.contains("function") and line.contains(") :: Int64") and " :: Int64" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (") :: Int64", ") -> i64 {\n")))

        elif line.contains("function") and line.contains(")::Int32") and "::Int32" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (")::Int32", ") -> i32 {\n")))
        
        elif line.contains("function") and line.contains(") :: Int32") and " :: Int32" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (") :: Int32", ") -> i32 {\n")))

        elif line.contains("function") and line.contains(")::Float64") and "::Float64" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (")::Float64", ") -> f64 {\n")))
        
        elif line.contains("function") and line.contains(") :: Float64") and " :: Float64" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (") :: Float64", ") -> f64 {\n")))

        elif line.contains("function") and line.contains(")::Float32") and "::Float32" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (")::Float32", ") -> f32 {\n")))
        
        elif line.contains("function") and line.contains(") :: Float32") and " :: Float32" notin line:
            rustFile.writeLine(line.multiReplace(("function", "fn"), (") :: Float32", ") -> f32 {\n")))


        elif line.contains("function") and line.contains("::UInt64") and line.contains(")::UInt64"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), ("::UInt64", ": u64"), (")::UInt64", ") -> u64 {\n")))
        
        elif line.contains("function") and line.contains(" :: UInt64") and line.contains(") :: UInt64"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: UInt64", ": u64"), (") :: UInt64", ") -> u64 {\n")))

        elif line.contains("function") and line.contains("::UInt32") and line.contains(")::UInt32"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), ("::UInt32", ": u32"), (")::UInt32", ") -> u32 {\n")))

        elif line.contains("function") and line.contains(" :: UInt32") and line.contains(") :: UInt32"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: UInt32", ": u32"), (") :: UInt32", ") -> u32 {\n")))

        elif line.contains("function") and line.contains("::Int64") and line.contains(")::Int64"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), ("::Int64", ": i64"), (")::Int64", ") -> i64 {\n")))
        
        elif line.contains("function") and line.contains(" :: Int64") and line.contains(") :: Int64"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: Int64", ": i64"), (") :: Int64", ") -> i64 {\n")))

        elif line.contains("function") and line.contains("::Int32") and line.contains(")::Int32"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), ("::Int32", ": i32"), (")::Int32", ") -> i32 {\n")))
        
        elif line.contains("function") and line.contains(" :: Int32") and line.contains(") :: Int32"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: Int32", ": i32"), (") :: Int32", ") -> i32 {\n")))

        elif line.contains("function") and line.contains("::Float64") and line.contains(")::Float64"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), ("::Float64", ": f64"), (")::Float64", ") -> f64 {\n")))
        
        elif line.contains("function") and line.contains(" :: Float64") and line.contains(") :: Float64"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: Float64", ": f64"), (") :: Float64", ") -> f64 {\n")))


        elif line.contains("function") and line.contains("::Float32") and line.contains(")::Float32"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), ("::Float32", ": f32"), (")::Float32", ") -> f32 {\n")))
        
        elif line.contains("function") and line.contains(" :: Float32") and line.contains(") :: Float32"):
            rustFile.writeLine(line.multiReplace(("function", "fn"), (" :: Float32", ": f32"), (") :: Float32", ") -> f32 {\n")))

        elif line.contains(" = ") and "begin" notin line:
            rustFile.write("\tlet mut ", line.replace("\t", ""))
            rustFile.writeLine(";")

        elif line.contains(" = ") and line.contains("begin") and "::" notin line:
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{"), ("\t", "")))
            rustFile.writeLine(";")

        elif line.contains(" = ") and line.contains("begin") and line.contains("::UInt64"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), ("::UInt64", ": u64")))

        elif line.contains(" = ") and line.contains("begin") and line.contains(" :: UInt64"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), (" :: UInt64", ": u64")))
        
        elif line.contains(" = ") and line.contains("begin") and line.contains("::UInt32"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), ("::UInt32", ": u32")))
        
        elif line.contains(" = ") and line.contains("begin") and line.contains(" :: UInt32"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), (" :: UInt32", ": u32")))

        elif line.contains(" = ") and line.contains("begin") and line.contains("::Int64"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), ("::Int64", ": i64")))
        
        elif line.contains(" = ") and line.contains("begin") and line.contains(" :: Int64"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), (" :: Int64", ": i64")))

        elif line.contains(" = ") and line.contains("begin") and line.contains("::Int32"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), ("::Int32", ": i32")))
        
        elif line.contains(" = ") and line.contains("begin") and line.contains(" :: Int32"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), (" :: Int32", ": i32")))

        elif line.contains(" = ") and line.contains("begin") and line.contains("::Floa64"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), ("::Float64", ": f64")))
        
        elif line.contains(" = ") and line.contains("begin") and line.contains(" :: Float64"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), (" :: Float64", ": f64")))

        elif line.contains(" = ") and line.contains("begin") and line.contains("::Float32"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), ("::Float32", ": f32")))
        
        elif line.contains(" = ") and line.contains("begin") and line.contains(" :: Float32"):
            rustFile.write("\tlet mut ", line.multiReplace(("begin", "{\n"), ("\t", ""), (" :: Float32", ": f32")))

        elif line.contains("println("):
            rustFile.write(line.replace("println(", "println!(\"{:?}\", "))
            rustFile.writeLine(";")

        elif line.contains("print("):
            rustFile.write(line.replace("print(", "print!(\"{:?}\", "))
            rustFile.writeLine(";")

        elif line.contains("return"):
            rustFile.write(line)
            rustFile.writeLine(";")

        elif line.contains("end") and "]" notin line: rustFile.writeLine(
                line.replace("end", "}"))

        elif line.contains("if") and "else" notin line: rustFile.write(line, " {\n")

        elif line.contains("elseif"): rustFile.write("\t} ", line.multiReplace((
                "elseif", "else if"), ("\t", "")), " {\n")

        elif line.contains("else") and "if" notin line: rustFile.write("\t} ",
                line.replace("\t", ""), " {\n")

        elif line.contains("for") and line.contains(":"):
            rustFile.write(line.replace(":", ".."))
            rustFile.write(" + 1")
            rustFile.writeLine(" {")

        elif line.contains("for") and ":" notin line:
            rustFile.write(line)
            rustFile.writeLine(" {")

        else: rustFile.writeLine(line)

let args = commandLineParams()

if args.len() == 1:
    let juliaFile = args[0]
    if juliaFile[juliaFile.len() - 3 .. juliaFile.len() - 1] == ".jl":
        translate(juliaFile)
    else: help()
else: help()
