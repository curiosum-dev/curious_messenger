defmodule CuriousMessengerWeb.PageController do
  use CuriousMessengerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
