defmodule Nextup.Repo.Migrations.RelateSetsToCards do
  use Ecto.Migration

  def change do
    create table(:sets_cards, primary_key: false) do
      add :set_id, references(:sets)
      add :card_id, references(:cards, on_delete: :delete_all)
    end
  end
end
