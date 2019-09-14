defmodule Categories.ApiMobile.Category do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t()
        }
  defstruct [:id, :name]

  field :id, 1, type: :string
  field :name, 2, type: :string
end

defmodule Categories.ApiMobile.CategoriesFetchAllRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          page_size: integer,
          page_token: String.t()
        }
  defstruct [:page_size, :page_token]

  field :page_size, 1, type: :int32
  field :page_token, 2, type: :string
end

defmodule Categories.ApiMobile.CategoriesFetchAllResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          categories: [Categories.ApiMobile.Category.t()],
          next_page_token: String.t()
        }
  defstruct [:categories, :next_page_token]

  field :categories, 1, repeated: true, type: Categories.ApiMobile.Category
  field :next_page_token, 2, type: :string
end

defmodule Categories.ApiMobile.CategoriesMobileService.Service do
  @moduledoc false
  use GRPC.Service, name: "categories.api_mobile.CategoriesMobileService"

  rpc :CategoriesFetchAll,
      Categories.ApiMobile.CategoriesFetchAllRequest,
      stream(Categories.ApiMobile.CategoriesFetchAllResponse)
end

defmodule Categories.ApiMobile.CategoriesMobileService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Categories.ApiMobile.CategoriesMobileService.Service
end
