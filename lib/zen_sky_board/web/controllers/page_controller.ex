defmodule ZenSkyBoard.Web.PageController do
  use ZenSkyBoard.Web, :controller

  alias ZenSkyBoard.Dashboard

  def index(conn, _params) do
    lights = Dashboard.list_lights()
    render(conn, "index.html", lights: lights)
  end
end
