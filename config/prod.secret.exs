use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :sky_lights, SkyLights.Web.Endpoint,
  secret_key_base: "HZGJY6MRtjmuiDuW4J3sSJz8XW9vXR6EHtMKClYcKhH3COIfjPkARMKrpFrzVgS0"

# Configure your database
config :sky_lights, SkyLights.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "sky_lights_prod",
  pool_size: 15
