defmodule ZenSkyBoard.Dashboard do

  import Ecto.{Query, Changeset}, warn: false
  alias ZenSkyBoard.Repo
  alias ZenSkyBoard.Dashboard.Light

  def list_lights do
    Repo.all(Light)
  end

  def get_light!(id), do: Repo.get!(Light, id)

  def get_light_by_cpuid(cpuid), do: Repo.get_by(Light, cpuid: cpuid)

  def create_light(attrs \\ %{}) do
    %Light{}
    |> light_changeset(attrs)
    |> Repo.insert()
  end

  def update_light(%Light{} = light, attrs) do
    light
    |> color_changeset(attrs)
    |> Repo.update()
  end

  def delete_light(%Light{} = light) do
    Repo.delete(light)
  end

  def change_light(%Light{} = light) do
    light_changeset(light, %{})
  end

  defp light_changeset(%Light{} = light, attrs) do
    light
    |> cast(attrs, [:slack_handle, :full_name, :color, :slack_token, :cpuid])
    |> validate_required([:slack_handle, :full_name, :color, :slack_token, :cpuid])
    |> unique_constraint(:cpuid)
  end

  defp color_changeset(%Light{} = light, attrs) do
    light
    |> cast(attrs, [:color])
    |> validate_required([:color])
  end
end
