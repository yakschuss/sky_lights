defmodule ZenSkyBoard.Web.DashboardChannel do
  use ZenSkyBoard.Web, :channel

  alias ZenSkyBoard.Endpoint

  def join("dashboard:lobby", payload, socket) do
    {:ok, "Joined!", socket}
  end

  def broadcast_change(light) do
    payload = %{
      "slack_handle" => light.slack_handle,
      "full_name" => light.full_name,
      "color" => light.color,
      "slack_token" => light.slack_token,
      "cpuid" => light.cpuid,
      "id" => light.id,
    }

    Endpoint.broadcast("dashboard:lobby", "change", payload)
  end

  def broadcast_delete(cpuid) do
    payload = %{
      "cpuid" => cpuid,
    }

    Endpoint.broadcast("dashboard:lobby", "delete", payload)
  end

  def broadcast_connect(light) do
    payload = %{
      "cpuid" => light.cpuid,
      "color" => light.color,
    }

    Endpoint.broadcast("dashboard:lobby", "connect", payload)
  end
end
