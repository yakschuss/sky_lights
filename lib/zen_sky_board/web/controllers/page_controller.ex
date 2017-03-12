defmodule ZenSkyBoard.Web.PageController do
  use ZenSkyBoard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
