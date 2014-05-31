defmodule Parse do

  def printable?(char_list), do: Enum.any?(char_list, &(_ascii_digits(&1)))
  def anagram?(word_one, word_two), do: _normalize_word(word_one) == _normalize_word(word_two)
  def calculate(equation) do
    [left_operand, operator, right_operand] = String.split(equation)
    left_operand = String.to_integer(left_operand)
    right_operand = String.to_integer(right_operand)
    _perform_calculation(left_operand, operator, right_operand)
  end

  defp _ascii_digits(char), do: (char >= ?\s && char <= ?~)
  defp _normalize_word(word), do: String.downcase(word) |> String.codepoints |> Enum.sort
  defp _perform_calculation(left, "+", right), do: left + right
  defp _perform_calculation(left, "-", right), do: left - right
  defp _perform_calculation(left, "*", right), do: left * right
  defp _perform_calculation(left, "/", right), do: left / right
end

ExUnit.start

defmodule ParseTest do
  use ExUnit.Case

  test "calculate takes a string representation of a calculation and performs it" do
    assert Parse.calculate("5 + 5") == 10
  end
end
