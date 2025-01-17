defmodule YamlConfigProvider.MixProject do
  use Mix.Project

  def project do
    [
      app: :yaml_config_provider,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        all: [
          config_providers: [
            {
              YamlConfigProvider,
              yml_config_file: "test/test1.yml"
            }
          ]
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {YamlConfigProvider.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:yaml_elixir, "~> 2.4"},
    ]
  end
end
