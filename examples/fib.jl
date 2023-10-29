function main()

	z :: Float64 = begin
		m = 5
		n = 8
		m / n
	end;

	println(z)

	x = [0, 1, 2, 3, 4]
	for i in x
		println(fib(i))
	end
end

function fib(n :: UInt64) :: UInt64
	if n == 0
		return 0
	elseif n == 1
		return 1
	else
		return fib(n - 2) + fib(n - 1)
	end
end

function showPi() :: Float64
	return PI	
end