defmodule Nextup.Sets.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nextup.Sets.Group
  alias Nextup.Sets.User
  alias Nextup.Sets.Set


  schema "groups" do
    field :body, :string
    field :title, :string

    belongs_to :user, User
    has_many :sets, Set

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
