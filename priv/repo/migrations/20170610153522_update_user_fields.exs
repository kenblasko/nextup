defmodule Nextup.Repo.Migrations.UpdateUserFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :providerUID, :string

    end
  end
end
