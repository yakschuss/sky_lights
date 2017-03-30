defmodule SkyLights.Web.Router do
  use SkyLights.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

  end

  scope "/", SkyLights.Web do
    pipe_through :browser # Use the default browser stack

    get "/slack", PageController, :slack
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SkyLights.Web do
    pipe_through :api

    post "/lights", LightController, :create
    post "/lights/:uid", LightController, :delete
    post "/update_light/:uid", LightController, :update
    post "/heartbeat/:uid", LightController, :heartbeat
  end
end
