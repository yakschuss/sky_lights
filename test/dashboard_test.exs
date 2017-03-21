defmodule ZenSkyBoard.DashboardTest do
  use ZenSkyBoard.DataCase

  alias ZenSkyBoard.Dashboard
  alias ZenSkyBoard.Dashboard.Light

  @create_attrs %{color: "some color", uid: 42, full_name: "some full_name", slack_handle: "some slack_handle", slack_token: "some slack_token"}
  @update_attrs %{color: "some updated color", uid: 43, full_name: "some updated full_name", slack_handle: "some updated slack_handle", slack_token: "some updated slack_token"}
  @invalid_attrs %{color: nil, uid: nil, full_name: nil, slack_handle: nil, slack_token: nil}

  def fixture(:light, attrs \\ @create_attrs) do
    {:ok, light} = Dashboard.create_light(attrs)
    light
  end

  test "list_lights/1 returns all lights" do
    light = fixture(:light)
    assert Dashboard.list_lights() == [light]
  end

  test "get_light! returns the light with given id" do
    light = fixture(:light)
    assert Dashboard.get_light!(light.id) == light
  end

  test "create_light/1 with valid data creates a light" do
    assert {:ok, %Light{} = light} = Dashboard.create_light(@create_attrs)
    
    assert light.color == "some color"
    assert light.uid == 42
    assert light.full_name == "some full_name"
    assert light.slack_handle == "some slack_handle"
    assert light.slack_token == "some slack_token"
  end

  test "create_light/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Dashboard.create_light(@invalid_attrs)
  end

  test "update_light/2 with valid data updates the light" do
    light = fixture(:light)
    assert {:ok, light} = Dashboard.update_light(light, @update_attrs)
    assert %Light{} = light
    
    assert light.color == "some updated color"
    assert light.uid == 43
    assert light.full_name == "some updated full_name"
    assert light.slack_handle == "some updated slack_handle"
    assert light.slack_token == "some updated slack_token"
  end

  test "update_light/2 with invalid data returns error changeset" do
    light = fixture(:light)
    assert {:error, %Ecto.Changeset{}} = Dashboard.update_light(light, @invalid_attrs)
    assert light == Dashboard.get_light!(light.id)
  end

  test "delete_light/1 deletes the light" do
    light = fixture(:light)
    assert {:ok, %Light{}} = Dashboard.delete_light(light)
    assert_raise Ecto.NoResultsError, fn -> Dashboard.get_light!(light.id) end
  end

  test "change_light/1 returns a light changeset" do
    light = fixture(:light)
    assert %Ecto.Changeset{} = Dashboard.change_light(light)
  end
end
