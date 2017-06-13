defmodule Nextup.Repo.Migrations.CreateNextup.Sets.Group do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :title, :string
      add :body, :string

      timestamps()
    end

  end
end
