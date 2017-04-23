defmodule Stacker.Stash do
  use GenServer

  #####
  # External API

  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack)
  end

  def get_value(stash_pid) do
    GenServer.call stash_pid, :get_value
  end

  def save_value(stash_pid, stack) do
    GenServer.cast stash_pid, {:save_value, stack}
  end

  #####
  # GenServer implementation

  def handle_call(:get_value, _from, stash) do
    { :reply, stash, stash }
  end

  def handle_cast({:save_value, value}, _current_value) do
    { :noreply, value }
  end
end
