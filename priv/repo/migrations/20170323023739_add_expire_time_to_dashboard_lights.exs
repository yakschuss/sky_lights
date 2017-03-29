defmodule ZenSkyBoard.Repo.Migrations.AddExpireTimeToDashboardLights do
  use Ecto.Migration

  def change do
    alter table(:dashboard_lights) do
      add :expire_time, :naive_datetime
    end
  end
end
