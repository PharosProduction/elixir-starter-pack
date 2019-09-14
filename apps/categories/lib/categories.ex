defmodule Categories do
  @moduledoc false

  alias Categories.ApiMobile.{
    CategoriesMobileService,
    Interceptors,
    CategoriesFetchAllRequest
  }
  
  # Public

  def grpc_categories_fetch_all(page_size \\ 3, page_token \\ "abc", jwt \\ "def") do
    headers = %{"jwt" => jwt}
    trailers = %{}
    metadata = Map.merge(headers, trailers)
    
    req = CategoriesFetchAllRequest.new(page_size: page_size, page_token: page_token)

    channel = create_channel()    
    with {:ok, enum} <- CategoriesMobileService.Stub.categories_fetch_all(channel, req, metadata: metadata) do
      res = Enum.to_list(enum)
      |> Enum.map(&(elem(&1, 1)))

      GRPC.Stub.disconnect(channel)
      res
    else
      {:error, %GRPC.RPCError{message: msg, status: _}} -> {:error, msg}
    end
  end
  
  # Private

  defp create_channel do
    ssl_cert = Path.expand(Application.get_env(:categories, :ssl_cert), :code.priv_dir(:categories))
    ssl_key = Path.expand(Application.get_env(:categories, :ssl_key), :code.priv_dir(:categories))
    ssl = [certfile: ssl_cert, keyfile: ssl_key]
    cred = GRPC.Credential.new(ssl: ssl)

    host = Application.get_env(:categories, :grpc_host)
    port = Application.get_env(:categories, :grpc_port)
    interceptors = [
      GRPC.Logger.Client,
      Interceptors.AuthClient
    ]
    {:ok, channel} = GRPC.Stub.connect(
      "#{host}:#{port}", 
      interceptors: interceptors, 
      cred: cred, 
      timeout: 20_000, 
      deadline: 20_000)
    
    channel
  end
end
