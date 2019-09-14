defmodule Categories.ApiMobile.Interceptors.AuthServer do

  @behaviour GRPC.ServerInterceptor

  # Callbacks

  @impl true
  def init(opts), do: opts

  @impl true
  def call(req, stream, next, _opts) do
    try do
      with _headers <- GRPC.Stream.get_headers(stream) do
        payload = Map.put(stream.payload, :claims, "abc")
        next.(req, %{stream | payload: payload})
      else
        {:error, err} -> throw %GRPC.RPCError{message: err, status: 16}
      end
    rescue
      e in WithClauseError -> 
        case e do
          %WithClauseError{term: {:error, {"ValidationException", reason}}} -> throw %GRPC.RPCError{message: reason, status: 13}
          _ -> throw %GRPC.RPCError{message: "Missed authentication token", status: 16}
        end
    end
  end
end 