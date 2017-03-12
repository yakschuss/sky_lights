defmodule ZenSkyBoard.Dashboard do
  @moduledoc """
  The boundary for the Dashboard system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias ZenSkyBoard.Repo

  alias ZenSkyBoard.Dashboard.Light

  @doc """
  Returns the list of lights.

  ## Examples

      iex> list_lights()
      [%Light{}, ...]

  """
  def list_lights do
    Repo.all(Light)
  end

  @doc """
  Gets a single light.

  Raises `Ecto.NoResultsError` if the Light does not exist.

  ## Examples

      iex> get_light!(123)
      %Light{}

      iex> get_light!(456)
      ** (Ecto.NoResultsError)

  """
  def get_light!(id), do: Repo.get!(Light, id)

  @doc """
  Creates a light.

  ## Examples

      iex> create_light(light, %{field: value})
      {:ok, %Light{}}

      iex> create_light(light, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_light(attrs \\ %{}) do
    %Light{}
    |> light_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a light.

  ## Examples

      iex> update_light(light, %{field: new_value})
      {:ok, %Light{}}

      iex> update_light(light, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_light(%Light{} = light, attrs) do
    light
    |> light_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Light.

  ## Examples

      iex> delete_light(light)
      {:ok, %Light{}}

      iex> delete_light(light)
      {:error, %Ecto.Changeset{}}

  """
  def delete_light(%Light{} = light) do
    Repo.delete(light)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking light changes.

  ## Examples

      iex> change_light(light)
      %Ecto.Changeset{source: %Light{}}

  """
  def change_light(%Light{} = light) do
    light_changeset(light, %{})
  end

  defp light_changeset(%Light{} = light, attrs) do
    light
    |> cast(attrs, [:slack_handle, :full_name, :color, :slack_token, :cpuid])
    |> validate_required([:slack_handle, :full_name, :color, :slack_token, :cpuid])
  end
end
