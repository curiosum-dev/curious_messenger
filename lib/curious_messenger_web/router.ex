defmodule CuriousMessengerWeb.Router do
  use CuriousMessengerWeb, :router
  use Pow.Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {CuriousMessengerWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", CuriousMessengerWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/conversations/:conversation_id/users/:user_id", ConversationLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", CuriousMessengerWeb do
  #   pipe_through :api
  # end
end
