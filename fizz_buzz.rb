def fizz_buzz(num)
  if num % 5 == 0 && num % 3 == 0
    "FizzBuzz"
  elsif num % 5 == 0
    "Buzz"
  elsif num % 3 == 0
    "Fizz"
  else
    num
  end
end

1..100.times { |i| IO.puts fizz_buzz(num) }
