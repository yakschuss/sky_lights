defmodule SkyLights.Web.LightControllerTest do
  use SkyLights.Web.ConnCase

  alias SkyLights.Dashboard
  alias SkyLights.Dashboard.Light

  @create_attrs %{color: "some color", uid: 42, full_name: "some full_name", slack_handle: "some slack_handle", slack_token: "some slack_token"}
  @update_attrs %{color: "some updated color", uid: 43, full_name: "some updated full_name", slack_handle: "some updated slack_handle", slack_token: "some updated slack_token"}
  @invalid_attrs %{color: nil, uid: nil, full_name: nil, slack_handle: nil, slack_token: nil}

  def fixture(:light) do
    {:ok, light} = Dashboard.create_light(@create_attrs)
    light
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, light_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates light and renders light when data is valid", %{conn: conn} do
    conn = post conn, light_path(conn, :create), light: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, light_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "color" => "some color",
      "uid" => 42,
      "full_name" => "some full_name",
      "slack_handle" => "some slack_handle",
      "slack_token" => "some slack_token"}
  end

  test "does not create light and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, light_path(conn, :create), light: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen light and renders light when data is valid", %{conn: conn} do
    %Light{id: id} = light = fixture(:light)
    conn = put conn, light_path(conn, :update, light), light: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, light_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "color" => "some updated color",
      "uid" => 43,
      "full_name" => "some updated full_name",
      "slack_handle" => "some updated slack_handle",
      "slack_token" => "some updated slack_token"}
  end

  test "does not update chosen light and renders errors when data is invalid", %{conn: conn} do
    light = fixture(:light)
    conn = put conn, light_path(conn, :update, light), light: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen light", %{conn: conn} do
    light = fixture(:light)
    conn = delete conn, light_path(conn, :delete, light)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, light_path(conn, :show, light)
    end
  end
end
