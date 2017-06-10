defmodule Nextup.Repo.Migrations.CreateNextup.Sets.Set do
  use Ecto.Migration

  def change do
    create table(:sets) do
      add :title, :string
      add :body, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
