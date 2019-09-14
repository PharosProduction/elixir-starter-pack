defmodule Categories.Repo do
  @moduledoc false

  # Public

  @spec fetch_all(pos_integer, binary) :: {:ok, list(map), binary}
  def fetch_all(_page_size, _page_token) do
    categories = [
      %{
        id: "abc",
        name: "Food"
      },
      %{
        id: "def",
        name: "Concerts"
      },
      %{
        id: "xyz",
        name: "Meetups"
      }
    ]
    next_page_token = "xyz"

    {:ok, categories, next_page_token}
  end
end