defmodule ZenSkyBoard.Web.LightController do
  use ZenSkyBoard.Web, :controller

  alias ZenSkyBoard.Dashboard
  alias ZenSkyBoard.Dashboard.Light
  alias ZenSkyBoard.Dashboard.HeartBeat
  alias ZenSkyBoard.Web.DashboardChannel

  action_fallback ZenSkyBoard.Web.FallbackController

  def create(conn, %{"light" => light_params}) do
    case Dashboard.create_light(light_params) do
      {:ok, light} ->
        DashboardChannel.broadcast_connect(light)
        HeartBeat.start_link(light.uid)

        conn
        |> put_status(:created)
        |> render("light.json", light: light)


      {:error, changeset} ->
        %{"uid" => uid} = light_params
        light = Dashboard.get_light_by_uid(uid)

        Dashboard.update_light(light, light_params)
        DashboardChannel.broadcast_change(light)
        HeartBeat.reset_expiry(light.uid)

        conn
        |> put_status(:no_content)
        |> render("light.json", light: light)
    end
  end

  def update(conn, %{"uid" => uid, "light" => light_params}) do
    light = Dashboard.get_light_by_uid(uid)

    with {:ok, %Light{} = light} <- Dashboard.update_light(light, light_params) do
      DashboardChannel.broadcast_change(light)
      HeartBeat.reset_expiry(light.uid)
      conn
      |> put_status(:created)
      |> render("light.json", light: light)
    end
  end

  def delete(conn, %{"uid" => uid}) do
    light = Dashboard.get_light_by_uid(uid)
    with {:ok, %Light{}} <- Dashboard.delete_light(light) do
      DashboardChannel.broadcast_delete(uid)
      HeartBeat.terminate_process(uid)
      conn
      |> put_status(:ok)
      |> render("light.json", light: light)
    end
  end
end
