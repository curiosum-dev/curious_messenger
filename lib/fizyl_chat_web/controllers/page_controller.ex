defmodule FizylChatWeb.PageController do
  use FizylChatWeb, :controller

  plug FizylChatWeb.AssignUser, preload: :conversations

  def index(conn, opts \\ []) do
    render(conn, "index.html")
  end
end
