defmodule ZenSkyBoard.Web.LightView do
  use ZenSkyBoard.Web, :view
  alias ZenSkyBoard.Web.LightView

  def render("index.json", %{lights: lights}) do
    %{data: render_many(lights, LightView, "light.json")}
  end

  def render("show.json", %{light: light}) do
    %{data: render_one(light, LightView, "light.json")}
  end

  def render("light.json", %{light: light}) do
    %{
      id: light.id,
      slack_handle: light.slack_handle,
      full_name: light.full_name,
      color: light.color,
      slack_token: light.slack_token,
      cpuid: light.cpuid
    }
  end
end
