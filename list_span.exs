defmodule MyList do
  def span(from = to, to), do: [from]
  def span(from, to), do: [from] ++ span(from + 1, to)
end
