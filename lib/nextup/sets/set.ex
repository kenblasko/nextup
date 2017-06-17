defmodule Nextup.Sets.Set do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  
  alias Nextup.Repo
  alias Nextup.Admin.User
  alias Nextup.Sets.Set
  alias Nextup.Sets.Card
  alias Nextup.Sets.Group

  schema "sets" do
    field :title, :string
    field :body, :string
    field :order, :map

    belongs_to :user, User
    belongs_to :group, Group
    many_to_many :cards, Card, join_through: "sets_cards", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Set{} = set, attrs \\ %{}) do
    card_ids = if attrs["cards"]["ids"], do: attrs["cards"]["ids"], else: []
    card_priorities = if attrs["cards"]["priorities"], do: attrs["cards"]["priorities"], else: []

    set
      |> cast(attrs, [:title, :body, :user_id])
      |> cast(build_order(card_ids, card_priorities), [:order])
      |> put_assoc(:cards, get_cards(card_ids))
      |> validate_required([:title, :body])
  end

  defp get_cards(ids) do
    Card 
      |> where([c], c.id in ^ids) 
      |> Repo.all
  end

  defp build_order(priorities, ids) do
    %{"order" => Enum.zip(priorities, ids) |> Enum.into(%{})}
  end
end
