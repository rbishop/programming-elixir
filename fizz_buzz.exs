fizz_buzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, c) -> c
end

fizz_buzz_rem = fn (num) -> fizz_buzz.(rem(num,3), rem(num, 5), num) end

Enum.map 1..100, &(IO.puts fizz_buzz_rem.(&1))
