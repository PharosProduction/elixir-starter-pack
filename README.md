# Elixir Starter Pack

## Usage

To launch the app run from the console:
1. `mix deps.get` - to fetch all the dependencies
2. `iex -S mix` - to run REPL (Read-Eval-Print Loop)

From REPL run:
`Categories.grpc_categories_fetch_all(1, "aaa", "asf")`
to send a gRPC request and get a response.

## Supported Versions

Elixir veresion 1.9.x

## Useful commands

1. `protoc --elixir_out=plugins=grpc:./ ./apps/categories/lib/categories/api_mobile/*.proto` to generate service module from proto file
2. `mix deps.get`
3. `mix deps.compile`
4. `mix deps.clean mime --build`
5. `mix format`
6. `mix docs`
7. `mix test`
8. `mix dialyzer --format dialyzer`
9. `mix dialyzer --halt-exit-status`
10. `mix credo`
11. `MIX_ENV=test mix cover`
12. `mix xref unreachable`
13. `mix xref deprecated`
14. `HOSTNAME=127.0.0.1 REPLACE_OS_VARS=true sh _build/prod/rel/excluster/bin/excluster console`

## Copyright and License

Created by [Dmytro Nasyrov, Founder, CTO at Pharos Production Inc.](https://www.linkedin.com/in/dmytro-nasyrov/)

[Pharos Production Inc. - Distributed Systems, Blockchain and FinTech enterprise software development](https://pharosproduction.com)

2019 Pharos Production Inc.