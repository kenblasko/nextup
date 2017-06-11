defmodule Nextup.Repo.Migrations.AddOrderToSets do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      add :order, :text # really not sure how long this will get 
    end
  end
end
