defmodule Nextup.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Nextup.Admin.User
  alias Nextup.Sets.Set
  alias Nextup.Sets.Card

  schema "users" do
    field :email, :string
    field :image, :string
    field :name, :string
    field :provider, :string
    field :providerUID, :string # This will be our unique identifier for facebook oauth
    field :token, :string

    has_many :sets, Set
    has_many :cards, Card

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :token, :image, :email, :provider, :providerUID])
    |> validate_required([:name, :token, :provider])
  end
end
