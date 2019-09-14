use Mix.Config

config :categories, 
  ssl_cert: "./ssl/server.crt",
  ssl_key: "./ssl/server.pem"

config :grpc, start_server: true

import_config "#{Mix.env()}.exs"