function main()
	x = [0, 1, 2, 3, 4]
	for i in x
		println(fib(i))
	end
end

function fib(n :: Int64) :: Int64
	if n == 0
		return 0
	elseif n == 1
		return 1
	else
		return fib(n - 2) + fib(n - 1)
	end
end