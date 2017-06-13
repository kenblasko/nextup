defmodule Nextup.Repo.Migrations.AddGroupsToSets do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      add :group_id, references(:groups, on_delete: :nothing)
      
    end
  end
end
