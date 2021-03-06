defmodule Stacker.Mixfile do
  use Mix.Project

  def project do
    [app: :stacker,
     version: "0.0.1",
     elixir: "~> 0.14.3",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
     applications: [],
     mod: {Stacker, []},
     env: [initial_stack: [1, "cat", 5]],
     registered: [ :stacker ]
    ]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
