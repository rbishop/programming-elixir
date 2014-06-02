defmodule MyBinary do
  def capitalize(string) do
    string
    |> String.split(~r{\.\s+})
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(". ")
  end

end

IO.puts MyBinary.capitalize "oh. a DOG. woof. "
