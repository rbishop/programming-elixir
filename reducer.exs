defmodule Reducer do
  def sum(list),          do: _reduce(list, &(&1 + &2))
  def multiply(list),     do: _reduce(list, &(&1 * &2))
  def max(list),          do: _reduce(list, &(max(&1, &2)))
  def min(list),          do: _reduce(list, &(min(&1, &2)))
  def mapsum(list, func), do: sum(_map(list, func))

  defp _map([head | []], func),   do: [func.(head)]
  defp _map([head | tail], func), do: [func.(head)] ++ _map(tail, func)
  
  defp _reduce([], _func),                    do: []
  defp _reduce([head | []], _func),           do: head
  defp _reduce([head | [next | tail]], func), do: _reduce([func.(head, next)] ++ tail, func)
end
