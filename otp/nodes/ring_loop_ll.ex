defmodule RingLoop do

  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :loop, [])
    :global.register_name(@name, pid)
  end

  def join do
    ring_leader = :global.whereis_name(@name)
    newest_pid = spawn(__MODULE__, :wait, [ring_leader])
    send ring_leader, { :join, newest_pid }
  end

  def loop do
    receive do
      { :join, pid } ->
        send pid, { :tick }
        wait(pid)
    end
  end

  def loop(neighbor) do
    ring_leader = :global.whereis_name(@name)
    receive do
      { :join, newest_pid } when neighbor == ring_leader ->
         loop(newest_pid) 
      { :join, newest_pid } ->
        send neighbor, { :join, newest_pid }
        loop(neighbor)
    after @interval ->
      send neighbor, { :tick }
      wait(neighbor)
    end
  end

  def wait(neighbor) do
    ring_leader = :global.whereis_name(@name)
    receive do
      { :join, newest_pid } when neighbor == ring_leader ->
        wait(newest_pid)
      { :join, newest_pid } ->
        send neighbor, { :join, newest_pid }
        wait(neighbor)
      { :tick } ->
        IO.puts "Tick"
        wait(neighbor)
    end
  end
end
