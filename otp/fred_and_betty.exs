defmodule FAndB do

  def reply(pid) do
    receive do
      message -> send pid, message
    end
  end

  def run do
    fred = spawn(FAndB, :reply, [self])
    betty = spawn(FAndB, :reply, [self])

    send fred, "fred"
    send betty, "betty"

    receive do
      message -> IO.puts message
    end

    receive do
       message -> IO.puts message
    end
  end
end
