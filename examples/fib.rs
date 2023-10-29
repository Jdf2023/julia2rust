fn main() {

	let mut z: f64 = {
	let mut m = 5.0;
	let mut n = 8.0;
		m / n
	};

	println!("{:?}", z);

	let mut x = [0, 1, 2, 3, 4];
	for i in x {
		println!("{:?}", fib(i));
	}
}

fn fib(n: u64) -> u64 {

	if n == 0 {
		return 0;
	} else if n == 1 {
		return 1;
	} else {
		return fib(n - 2) + fib(n - 1);
	}
}
