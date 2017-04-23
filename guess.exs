defmodule Chop do
  def guess(actual, lower..upper) do
    number = div(upper + lower, 2)
    IO.puts "Is it #{number}?"
    make_guess(number, actual, lower..upper)
  end

  def make_guess(number, actual, _) when number == actual do
    IO.puts "Nailed it!"
  end

  def make_guess(number, actual, lower.._) when number > actual do
    guess(actual, lower..number)
  end

  def make_guess(number, actual, _..upper) when number < actual do
    guess(actual, number..upper)
  end
end

Chop.guess(273, 1..1000)
