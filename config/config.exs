# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sky_lights,
  ecto_repos: [SkyLights.Repo]

# Configures the endpoint
config :sky_lights, SkyLights.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oWqpcvsC4vDzUtpmGOXBycpapesuKxJa7U/7u/lS/EYDAWHcZSTE6/cqPnzuT+xI",
  render_errors: [view: SkyLights.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SkyLights.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config :slack,
#   client_id: System.get_env("SLACK_CLIENT_ID"),
#   client_secret: System.get_env("SLACK_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
