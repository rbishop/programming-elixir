defmodule Stacker do
  use Application

  def start(_type, _args) do
    Stacker.Supervisor.start_link(Application.get_env(:stacker, :initial_stack))
  end
end
