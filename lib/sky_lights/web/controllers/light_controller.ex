defmodule SkyLights.Web.LightController do
  use SkyLights.Web, :controller

  alias SkyLights.Dashboard
  alias SkyLights.Dashboard.Light
  alias SkyLights.Dashboard.HeartBeat
  alias SkyLights.Web.DashboardChannel

  action_fallback SkyLights.Web.FallbackController

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

  def heartbeat(conn, %{"uid" => uid}) do
     HeartBeat.reset_expiry(uid)
     send_resp(conn, :ok, "")
   end

end
