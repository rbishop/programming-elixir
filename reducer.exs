defmodule Reducer do
  def sum([]),                     do: 0
  def sum([head | []]),            do: head
  def sum([head | [next | tail]]), do: sum([head + next] ++ tail)

  def multiply([]), do: 0
  def multiply([head | []]), do: head
  def multiply([head | [next | tail]]), do: multiply([head * next] ++ tail)
  
  def reduce([], _),                        do: []
  def reduce([head | []], _func),            do: head
  def reduce([head | [next | tail]], func), do: reduce([func.(head, next)] ++ tail, func)
end
