defmodule My do
  defmacro macro(code) do
    IO.inspect code
    code
  end
end

defmodule Test do
  require My

  My.macro(def hello, do: IO.puts "Hello")
end
