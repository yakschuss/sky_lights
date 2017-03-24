defmodule ZenSkyBoard.Web.DashboardChannel do
  use ZenSkyBoard.Web, :channel

  alias ZenSkyBoard.Web.Endpoint

  def join("dashboard:lobby", _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(light) do
    payload = %{
      "slack_handle" => light.slack_handle,
      "full_name" => light.full_name,
      "color" => light.color,
      "slack_token" => light.slack_token,
      "uid" => light.uid,
      "id" => light.id,
    }

    Endpoint.broadcast("dashboard:lobby", "change", payload)
  end

  def broadcast_delete(uid) do
    payload = %{
      "uid" => uid,
    }

    Endpoint.broadcast("dashboard:lobby", "delete", payload)
  end

  def broadcast_connect(light) do
    payload = %{
      "slack_handle" => light.slack_handle,
      "full_name" => light.full_name,
      "color" => light.color,
      "slack_token" => light.slack_token,
      "uid" => light.uid,
      "id" => light.id,
    }

    Endpoint.broadcast("dashboard:lobby", "connect", payload)
  end
end

