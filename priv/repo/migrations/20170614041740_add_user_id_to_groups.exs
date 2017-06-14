defmodule Nextup.Repo.Migrations.AddUserIdToGroups do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :user_id, references(:users, on_delete: :nothing)

    end
  end
end
