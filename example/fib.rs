fn main() {
	let mut 	x = [0, 1, 2, 3, 4];
	for i in x {
		println!("{:?}", fib(i));
	}
}

fn fib(n: i64) -> i64 {
	if n == 0 || n == 1 {
		return n;
	}
	return fib(n - 2) + fib(n - 1);
}
