defmodule ZenSkyBoard.Web.LightController do
  use ZenSkyBoard.Web, :controller

  alias ZenSkyBoard.Dashboard
  alias ZenSkyBoard.Dashboard.Light

  action_fallback ZenSkyBoard.Web.FallbackController

  def index(conn, _params) do
    lights = Dashboard.list_lights()
    render(conn, "index.json", lights: lights)
  end

  def create(conn, %{"light" => light_params}) do
    with {:ok, %Light{} = light} <- Dashboard.create_light(light_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", light_path(conn, :show, light))
      |> render("show.json", light: light)
    end
  end

  def show(conn, %{"id" => id}) do
    light = Dashboard.get_light!(id)
    render(conn, "show.json", light: light)
  end

  def update(conn, %{"cpuid" => cpuid, "light" => light_params}) do
    light = Dashboard.get_light_by_cpuid(cpuid)

    with {:ok, %Light{} = light} <- Dashboard.update_light(light, light_params) do
      render(conn, "show.json", light: light)
    end
  end

  def delete(conn, %{"id" => id}) do
    light = Dashboard.get_light!(id)
    with {:ok, %Light{}} <- Dashboard.delete_light(light) do
      send_resp(conn, :no_content, "")
    end
  end
end
