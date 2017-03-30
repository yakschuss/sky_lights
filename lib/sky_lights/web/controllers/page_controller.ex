defmodule SkyLights.Web.PageController do
  use SkyLights.Web, :controller

  alias SkyLights.Dashboard

  def slack(conn, _params) do
    render(conn, "slack.html")
  end

  def index(conn, _params) do
    lights = Dashboard.list_lights()
    render(conn, "index.html", lights: lights)
  end
end
