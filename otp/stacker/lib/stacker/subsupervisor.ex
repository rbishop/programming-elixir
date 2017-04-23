defmodule Stacker.SubSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    Supervisor.start_link(__MODULE__, stash_pid)
  end

  def init(stash_pid) do
    children = [ worker(Stacker.Server, [stash_pid]) ]
    supervise children, strategy: :one_for_one
  end
end
