defmodule Categories.Application do
  @moduledoc false

  use Application
  
  # Callbacks

  @impl true
  def start(_type, _args) do
    start_logger()

    children = [
      %{id: GRPC.Server.Supervisor, start: {GRPC.Server.Supervisor, :start_link, [grpc_args()]}}
    ]

    opts = [strategy: :one_for_one, name: Categories.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Private

  defp grpc_args do
    ssl = [
      certfile: Path.expand(Application.get_env(:categories, :ssl_cert), :code.priv_dir(:categories)),
      keyfile: Path.expand(Application.get_env(:categories, :ssl_key), :code.priv_dir(:categories))
    ]
    cred = GRPC.Credential.new(ssl: ssl)
    
    {
      Categories.ApiMobile.Endpoint, 
      Application.get_env(:categories, :grpc_port) |> String.to_integer, 
      cred: cred
    }
  end

  defp start_logger, do: :prometheus_httpd.start()
end
