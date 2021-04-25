# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fizyl_chat,
  ecto_repos: [FizylChat.Repo]

# Configures the endpoint
config :fizyl_chat, FizylChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1m10ShO0FK05tgr9HPV0aA5t41WshopK8XT3rr/wbfwTfB99HqlsP/aDY7343/Mi",
  render_errors: [view: FizylChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: FizylChat.PubSub,
  live_view: [
    signing_salt: "w9cORhPKD1TBowdK7sZpM9GkTs0d21Wk"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure Pow with user schema for authentication
config :fizyl_chat, :pow,
  user: FizylChat.Auth.User,
  repo: FizylChat.Repo,
  web_module: FizylChatWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
