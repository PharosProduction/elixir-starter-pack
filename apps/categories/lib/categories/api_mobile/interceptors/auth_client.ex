defmodule Categories.ApiMobile.Interceptors.AuthClient do
  
  @behaviour GRPC.ClientInterceptor

  # Callbacks

  @impl true
  def init(opts), do: opts

  @impl true
  def call(stream, req, next, _opts), do: next.(stream, req)
end