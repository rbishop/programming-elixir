defmodule My do
  defmacro macro(param) do
    IO.inspect param
  end
end

defmodule Test do
  require My

  # These values represent themselves
  My.macro :atom
  My.macro 1
  My.macro 1.0
  My.macro [1,2,3]
  My.macro do: 1

  # And these are represented by 3-element tuples
  My.macro { 1,2,3,4,5 }

  My.macro do: ( a = 1; a+a )

  My.macro do
    1+2
  else
    3+4
  end
end
