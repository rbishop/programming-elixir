defmodule Cascade do
  def seven_times(total) do
    _cascade(1, 7, total)
  end

  defp _cascade(0, _, _), do: []
  defp _cascade(num, stop, _) when num > stop, do: []
  defp _cascade(num, stop, total) when num > 0 do
    [ (total * (num * 0.036)) * 0.9985 | _cascade(num + 1, stop, total) ]
  end
end
