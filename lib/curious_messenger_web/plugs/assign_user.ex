defmodule CuriousMessengerWeb.AssignUser do
  import Plug.Conn

  alias CuriousMessenger.Auth.User
  alias CuriousMessenger.Repo

  def init(opts), do: opts

  def call(conn, params) do
    case Pow.Plug.current_user(conn) do
      %User{} = user ->
        assign(conn, :current_user, Repo.preload(user, params[:preload] || []))

      _ ->
        assign(conn, :current_user, nil)
    end
  end
end
