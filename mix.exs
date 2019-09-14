defmodule ElixirStarterPack.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),

      # Test
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_add_deps: :transitive,
        ignore_warnings: "dialyzer.ignore",
        list_unused_filters: true,
        halt_exit_status: true
      ],

      # Docs
      name: "Elixir Starter Pack",
      version: "0.1.0",
      source_url: "https://github.com/PharosProduction/",
      homepage_url: "https://pharosproduction.com",
      docs: [
        logo: "./images/logo.svg",
        output: "./docs",
        extras: ["README.md", "ENVIRONMENT.md"]
      ]
    ]
  end

  defp deps do
    [
      {:distillery, "~> 2.1", runtime: false},
      {:ex_doc, "~> 0.21", only: [:dev], runtime: false},
      {:poison, "~> 4.0", only: [:test], override: true},
      {:excoveralls, "~> 0.11", only: [:test]},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      credo: ["credo --strict"],
      cover: ["coveralls -u -v"],
      dialyze: ["dialyzer --format dialyzer"],
      test: ["test"]
    ]
  end
end
