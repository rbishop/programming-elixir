defmodule MyString do
  def center(words) do
    longest = _longest(words) |> String.length
    Enum.each words, fn (word) -> IO.puts _justify(word, longest) end
  end

  defp _longest(words), do: Enum.max_by(words, fn (word) -> String.length(word) end)
  defp _justify(word, longest), do: String.rjust(word, _offset(String.length(word), longest))

  defp _offset(word, longest) when word == longest, do: 0
  defp _offset(word, longest), do: (longest - word) / 2 |> round
end

MyString.center(~w{cat zebra elephant})
