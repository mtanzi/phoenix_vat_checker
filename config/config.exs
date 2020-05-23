# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :phoenix_vat_checker, PhoenixVatCheckerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Baqcuq8CRAGftozE3yk/PMyBnOhT48DBiUn/u0zb0b3YrIZ6yp0PTLNSBHF+mGxs",
  render_errors: [view: PhoenixVatCheckerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixVatChecker.PubSub,
  live_view: [signing_salt: "KkyboLVe"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
