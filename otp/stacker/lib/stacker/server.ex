defmodule Stacker.Server do
  use GenServer

  #####
  # External API

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  #####
  # GenServer implementation

  def init(stash_pid) do
    stack = Stacker.Stash.get_value(stash_pid)
    { :ok, {stack, stash_pid} }
  end

  def handle_call(:pop, _from, {[ head | stack ], stash_pid}) do
    { :reply, head, {stack, stash_pid} }
  end

  def handle_cast({:push, value}, {stack, stash_pid}) do
    { :noreply, {[ value | stack], stash_pid} }
  end

  def terminate(_reason, {stack, stash_pid}) do
    Stacker.Stash.save_value(stash_pid, stack)
  end

  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
