defmodule Ticker do

  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator([]) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid], [pid])
      after @interval ->
        IO.puts "tick"
        generator([])
    end
  end

  def generator(clients, []), do: generator(clients, clients)

  def generator(clients, waiting) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator(clients ++ [pid], waiting ++ [pid])
      after @interval ->
        IO.puts "tick"
        [next_client | rest] = waiting
        send next_client, { :tick }
        generator(clients, rest)
    end
  end
end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver
    end
  end
end
