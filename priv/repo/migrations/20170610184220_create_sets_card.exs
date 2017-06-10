defmodule Nextup.Repo.Migrations.CreateNextup.Sets.Card do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :title, :string
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
