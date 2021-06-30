defmodule FizylChatWeb.Router do
  use FizylChatWeb, :router
  use Pow.Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {FizylChatWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", FizylChatWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", FizylChatWeb do
    # Enable this to route traffic through protected route
    # pipe_through [:browser, :protected]
    
    pipe_through [:browser]

    resources "/conversations", ConversationController

    live "/conversations/:conversation_id/users/:user_id", ConversationLive, as: :conversation
  end

  # Other scopes may use custom stacks.
  # scope "/api", FizylChatWeb do
  #   pipe_through :api
  # end
end
