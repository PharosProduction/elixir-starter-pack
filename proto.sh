#!/bin/bash

protoc --elixir_out=plugins=grpc:./ ./apps/categories/lib/categories/api_mobile/*.proto