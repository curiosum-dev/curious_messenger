defmodule FizylChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      FizylChat.Repo,
      # Start the endpoint when the application starts
      FizylChatWeb.Endpoint,

      # Starts a worker by calling: FizylChat.Worker.start_link(arg)
      # {FizylChat.Worker, arg},
      {Phoenix.PubSub, [name: FizylChat.PubSub, adapter: Phoenix.PubSub.PG2]},
      Pow.Store.Backend.MnesiaCache,

      # Test websocket connection to Kraken websocket url
      # Throws an error if it doesn't come after the pubsub server for some reason 
      Ticker.Websocket
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FizylChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FizylChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
