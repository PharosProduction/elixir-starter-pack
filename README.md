# Elixir Starter Pack

To launch the app run from the console:
1. mix deps.get
2. iex -S mix

## Usage

## Supported Versions

## Important links

### Running tests

## Copyright and License

Created by [Dmytro Nasyrov, Founder, CTO at Pharos Production Inc.](https://www.linkedin.com/in/dmytro-nasyrov/)

[Pharos Production Inc. - Distributed Systems, Blockchain and FinTech enterprise software development](https://pharosproduction.com)

2019 Pharos Production Inc.

protoc --elixir_out=plugins=grpc:./ ./apps/categories/lib/categories/api_mobile/*.proto


mix deps.get
mix deps.compile
mix deps.clean mime --build
mix format
mix docs
mix test
mix dialyzer --format dialyzer
mix dialyzer --halt-exit-status
mix credo
MIX_ENV=test mix cover
mix xref unreachable
mix xref deprecated
HOSTNAME=127.0.0.1 REPLACE_OS_VARS=true sh _build/prod/rel/excluster/bin/excluster console

Categories.grpc_categories_fetch_all(1, "aaa", "asf")