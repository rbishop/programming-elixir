defmodule Sequence do
  use Application

  def start(_type, initial_number) do
    #Sequence.Supervisor.start_link(initial_number)
    {:ok, self}
  end
end
