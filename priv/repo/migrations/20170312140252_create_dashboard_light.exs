defmodule ZenSkyBoard.Repo.Migrations.CreateZenSkyBoard.Dashboard.Light do
  use Ecto.Migration

  def change do
    create table(:dashboard_lights) do
      add :slack_handle, :string
      add :full_name, :string
      add :color, :string
      add :slack_token, :string
      add :cpuid, :integer

      timestamps()
    end
    create unique_index(:dashboard_lights, [:cpuid])
  end
end
