defmodule CatFinder do
  def find(scheduler) do
    send scheduler, { :ready, self }
    receive do
      { :fib, file, client } ->
        send client, { :answer, file, find_cat(file), self }
        find(scheduler)
      { :shutdown } ->
        exit(0)
    end
  end

  defp find_cat(file) do
    File.read!("/Users/rb/code/reel/#{file}")
    |> String.split(" ")
    |> count_cat
  end

  defp count_cat(words) do
    words
    |> Enum.reduce(0,
                   fn (word, count) ->
                     count + (String.downcase(word) |> String.contains?("cat") |> has_cat)
                   end
                  )
  end

  defp has_cat(false), do: 0
  defp has_cat(true), do: 1
end
