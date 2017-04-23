import :timer, only: [ sleep: 1 ]

defmodule Link1 do
  def sad_function do
    sleep 500
    exit(99)
  end

  def run do
    res = spawn_monitor(Link1, :sad_function, [])
    IO.inspect res

    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
      after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
