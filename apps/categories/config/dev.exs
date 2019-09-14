use Mix.Config

config :categories,
  grpc_host: System.get_env("GRPC_HOST") || "127.0.0.1",
  grpc_port: System.get_env("GRPC_PORT") || "50051"