defmodule Nextup.Repo.Migrations.ChangeSetOrderToMap do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      remove :order
      add :order, :map
    end
  end
end
