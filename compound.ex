defmodule Interest do
  def compound(_, 0), do: balance
  def compound(balance, years) do
    new_bal = balance * 1.11
    compound(new_bal, years - 1)
  end
end

IO.puts Interest.compound(30000, 5)
