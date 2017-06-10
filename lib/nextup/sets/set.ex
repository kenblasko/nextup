defmodule Nextup.Sets.Set do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Nextup.Admin.User
  alias Nextup.Sets.Set
  alias Nextup.Sets.Card

  schema "sets" do
    field :title, :string
    field :body, :string

    belongs_to :user, User
    many_to_many :cards, Card, join_through: "sets_cards"

    timestamps()
  end

  @doc false
  def changeset(%Set{} = set, attrs) do
    set
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
