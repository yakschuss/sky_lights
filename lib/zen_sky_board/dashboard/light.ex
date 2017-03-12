defmodule ZenSkyBoard.Dashboard.Light do
  use Ecto.Schema
  
  schema "dashboard_lights" do
    field :slack_handle, :string
    field :full_name, :string
    field :color, :string
    field :slack_token, :string
    field :cpuid, :integer

    timestamps()
  end
end
