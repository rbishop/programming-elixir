defmodule RingLoop do

  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :state, [{ :wait }])
    :global.register_name(@name, pid)
  end

  def join do
    ring_leader = :global.whereis_name(@name)
    newest_pid = spawn(__MODULE__, :state, [:wait])
    send ring_leader, { :join, newest_pid }
  end

  def state({ _previous, :wait, neighbor }) do
    receive do
      { :join, new_loop } ->
        state({ :wait, :join, neighbor, new_loop })
      { :tick } ->
        IO.puts "Tick"
        state({ :wait, :tick, neighbor })
    end
  end

  def state({ previous, :join, neighbor, new_loop }) do
    send neighbor, { :join, new_loop }
    state({ :join, previous, neighbor })
  end

  def state({ _previous, :tick, neighbor }) do
    receive do
      { :join, new_loop } ->
        state({ :tick, :join, neighbor, new_loop })
    after @interval ->
      send neighbor, { :tick }
      state({ :tick, :wait, neighbor })
    end
  end
end
