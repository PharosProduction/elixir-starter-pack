defmodule Categories.ApiMobile.Server do
  @moduledoc false

  alias Categories.{
    ApiMobile,
    Repo
  }
  alias Categories.ApiMobile.{
    CategoriesMobileService,
    CategoriesFetchAllRequest,
    CategoriesFetchAllResponse
  }
  alias GRPC.{
    Status,
    RPCError
  }

  use GRPC.Server, service: CategoriesMobileService.Service

  # Public

  @spec categories_fetch_all(CategoriesFetchAllRequest.t, GRPC.Server.Stream.t) :: GRPC.Server.Stream.t
  def categories_fetch_all(%CategoriesFetchAllRequest{page_size: page_size, page_token: page_token}, stream) do
    with {:ok, categories, next_page_token} <- Repo.fetch_all(page_size, page_token) do
      grpc_categories = categories
      |> Enum.map(fn %{id: id, name: name} -> 
        %ApiMobile.Category{
          id: id, 
          name: name
        }
      end)

      reply = %CategoriesFetchAllResponse{categories: grpc_categories, next_page_token: next_page_token}
      GRPC.Server.send_reply(stream, reply)
    else
      _ -> throw %RPCError{message: "Categories are not available", status: 16}
    end
  end
end