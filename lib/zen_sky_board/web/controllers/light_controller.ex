defmodule ZenSkyBoard.Web.LightController do
  use ZenSkyBoard.Web, :controller

  alias ZenSkyBoard.Dashboard
  alias ZenSkyBoard.Dashboard.Light

  action_fallback ZenSkyBoard.Web.FallbackController

  def create(conn, %{"light" => light_params}) do
    with {:ok, %Light{} = light} <- Dashboard.create_light(light_params) do
      ZenSkyBoard.Endpoint.broadcast_connect(light)
      conn
    end
  end

  def update(conn, %{"cpuid" => cpuid, "light" => light_params}) do
    light = Dashboard.get_light_by_cpuid(cpuid)

    with {:ok, %Light{} = light} <- Dashboard.update_light(light, light_params) do
      ZenSkyBoard.Endpoint.broadcast_change(light)
    end
  end

  def delete(conn, %{"cpuid" => cpuid}) do
    light = Dashboard.get_light_by_cpuid(cpuid)
    with {:ok, %Light{}} <- Dashboard.delete_light(light) do
      ZenSkyBoard.Endpoint.broadcast_delete(cpuid)
    end
  end
end
