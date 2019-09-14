use Mix.Config

config :categories,
  grpc_host: System.get_env("GRPC_HOST") || "pharosproduction.com",
  grpc_port: System.get_env("GRPC_PORT") || "50051"