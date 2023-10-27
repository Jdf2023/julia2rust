import os, strutils

proc help() = echo "\nUsage:\n\tjulia2rust [file.jl]\n"

proc translate(juliaFile: string) =

    let contents = juliaFile.open()
    defer: contents.close()

    var fileName = juliaFile[0 .. juliaFile.len() - 4]
    fileName.add(".rs")

    var rustFile = open(fileName, fmWrite)
    defer: rustFile.close()

    for line in contents.lines():

        if line.contains("function") and line.contains("()"):
            rustFile.write(line.replace("function", "fn"))
            rustFile.writeLine(" {")

        elif line.contains("function") and line.contains("::UInt64") and line.contains(")::UInt64"):
            rustFile.write(line.multiReplace(("function", "fn"), ("::UInt64", ": u64"), (")::UInt64", ") -> u64")))
            rustFile.writeLine(" {")

        elif line.contains("function") and line.contains(" :: UInt64") and line.contains(") :: UInt64"):
            rustFile.write(line.multiReplace(("function", "fn"), (" :: UInt64", ": u64"), (") :: UInt64", ") -> u64")))
            rustFile.writeLine(" {")

        elif line.contains("function") and line.contains("::Int64") and line.contains(")::Int64"):
            rustFile.write(line.multiReplace(("function", "fn"), ("::Int64", ": i64"), (")::Int64", ") -> i64")))
            rustFile.writeLine(" {")

        elif line.contains("function") and line.contains(") :: Int64") and line.contains(" :: Int64"):
            rustFile.write(line.multiReplace(("function", "fn"), (") :: Int64", ") -> i64"), (" :: Int64", ": i64")))
            rustFile.writeLine(" {")

        elif line.contains(" = "):
            rustFile.write("\tlet mut ", line)
            rustFile.writeLine(";")

        elif line.contains("println("):
            rustFile.write(line.replace("println(", "println!(\"{:?}\", "))
            rustFile.writeLine(";")

        elif line.contains("print("):
            rustFile.write(line.replace("print(", "print!(\"{:?}\", "))
            rustFile.writeLine(";")

        elif line.contains("return"):
            rustFile.write(line)
            rustFile.writeLine(";")

        elif line.contains("end"): rustFile.writeLine(line.replace("end", "}"))

        elif line.contains("if"): rustFile.write(line, " {\n")

        elif line.contains("elseif"): rustFile.write(line.replace("elseif",
                "else if"), "{\n")

        elif line.contains("else"): rustFile.write(line, "{\n")

        elif line.contains("for") and line.contains(":"):
            rustFile.write(line.replace(" : ", " .. "))
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
