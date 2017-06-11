defmodule Nextup.Sets.Card do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nextup.Admin.User
  alias Nextup.Sets.Card
  alias Nextup.Sets.Set

  schema "cards" do
    field :title, :string
    field :body, :string

    belongs_to :user, User
    many_to_many :sets, Set, join_through: "sets_cards", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Card{} = card, attrs) do
    card
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body])
  end
end
