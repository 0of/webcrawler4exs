defmodule Webcrawler4exs.Mixfile do
  use Mix.Project

  def project do
    [app: :webcrawler4exs,
     version: "0.0.1",
     elixir: "~> 1.1",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
      [mod: {Webcrawler4exs, []}, 
       applications: [:phoenix, :phoenix_html, :cowboy, :logger, :httpoison, :postgrex]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
     [{:httpoison, "~> 0.8.0"},
       {:phoenix, "~> 1.1.4"},
       {:postgrex, ">= 0.0.0"},
       {:phoenix_html, "~> 2.4"},
       {:phoenix_live_reload, "~> 1.0", only: :dev},
       {:cowboy, "~> 1.0"}]
  end
end
