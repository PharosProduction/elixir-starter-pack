defmodule Categories.ApiMobile.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run Categories.ApiMobile.Server, interceptors: [Categories.ApiMobile.Interceptors.AuthServer]
end