defmodule Reducer do
  def sum(list),      do: _reduce(list, &(&1 + &2))
  def multiply(list), do: _reduce(list, &(&1 * &2))
  
  defp _reduce([], _),                        do: []
  defp _reduce([head | []], _func),           do: head
  defp _reduce([head | [next | tail]], func), do: _reduce([func.(head, next)] ++ tail, func)
end
