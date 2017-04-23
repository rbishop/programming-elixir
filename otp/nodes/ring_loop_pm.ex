defmodule RingLoop do
  
  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :first_loop, [])
    :global.register_name(@name, pid)
  end

  def join do
    starter_pid = :global.whereis_name(@name)
    new_pid = spawn(__MODULE__, :wait_for_tick, [starter_pid])
    send starter_pid, { :join, new_pid }
  end

  def first_loop do
    receive do
      { :join, pid } -> loop(pid, pid)
    after @interval ->
      first_loop
    end
  end

  def loop(next_pid) do
    receive do
      { :update, pid } ->
        loop(pid)
    after @interval ->
      send next_pid, { :tick }
      wait_for_tick(next_pid)
    end
  end

  def loop(next_pid, last_pid) do
    receive do
      { :join, new_last_pid } ->
        send last_pid, { :update, new_last_pid }
        loop(next_pid, new_last_pid)
      { :tick } ->
        IO.puts "Tick"
        wait_for_tick(next_pid, last_pid)
    after @interval ->
      send next_pid, { :tick }
      wait_for_tick(next_pid, last_pid)
    end
  end

  def wait_for_tick(next_pid) do
    receive do
      { :update, pid } ->
        wait_for_tick(pid)
      { :tick } ->
        IO.puts "Tick"
        loop(next_pid)
    end
  end

  def wait_for_tick(next_pid, last_pid) do
    receive do
      { :join, new_last_pid } ->
        send last_pid, { :update, new_last_pid }
        wait_for_tick(next_pid, new_last_pid)
      { :tick } ->
        IO.puts "Tick"
        loop(next_pid, last_pid)
    end
  end
end
