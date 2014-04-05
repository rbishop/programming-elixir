defmodule Caesar do
  def decode(list, num) do
    Enum.map list, &(_decode_char(&1, num))
  end

  defp _decode_char(char, num) when char + num > 122 do
    char + num - 26
  end

  defp _decode_char(char, num) when char + num < 122 do
    char + num
  end
end
