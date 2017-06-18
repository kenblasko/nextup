defmodule Nextup.Sets.Group do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Nextup.Admin.User
  alias Nextup.Repo
  alias Nextup.Sets.Group
  alias Nextup.Sets.Set


  schema "groups" do
    field :body, :string
    field :title, :string

    belongs_to :user, User
    has_many :sets, Set, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    set_ids = if attrs["sets"]["ids"], do: attrs["sets"]["ids"], else: []

    group
    |> cast(attrs, [:title, :body, :user_id])
    |> put_assoc(:sets, get_sets(set_ids))
    |> validate_required([:title, :body])
  end

  def get_sets(ids) do
    Set
      |> where([s], s.id in ^ids) 
      |> Repo.all
  end

end
