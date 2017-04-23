defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [app: :issues,
     version: "0.0.1",
     elixir: "~> 0.14.3",
     escript_main_module: Issues.CLI,
     name: "Issues",
     source_url: "https://github.com/rbishop/issues",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [ :httpotion ],
      mod: {Issues, []}
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
    [
      {:httpotion, github: "pragdave/httpotion"},
      {:jsx,       github: "talentdeficit/jsx"  },
      {:ex_doc,    github: "elixir-lang/ex_doc" }
    ]
  end
end
