include("fib.jl")

function main()
	x = [0, 1, 2, 3, 4]
	for i in x
		println(fib(i))
	end
end