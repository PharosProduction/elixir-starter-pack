defmodule Categories.MixProject do
  use Mix.Project

  def project do
    [
      app: :categories,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      dialyzer: [
        plt_add_deps: :transitive,
        plt_apps: [:erts, :kernel, :stdlib],
        flags: [
          "-Wunmatched_returns",
          "-Werror_handling",
          "-Wrace_conditions",
          "-Wunderspecs",
          "-Wno_opaque"
        ]
      ],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Categories.Application, []},
      registered: [ElixirStarterPack.Categories],
      env: [],
      extra_applications: [
        :sasl,
        :logger,
        :runtime_tools,
        :observer,
        :wx
      ]
    ]
  end

  defp deps do
    [
      {:grpc, github: "PharosProduction/grpc"},
      
      {:toml, "~> 0.5"},
      {:prometheus, "~> 4.4", override: true},
      {:prometheus_ex, "~> 3.0"},
      {:prometheus_plugs, "~> 1.1"},
      {:prometheus_httpd, "~> 2.1"}
    ]
  end
end
