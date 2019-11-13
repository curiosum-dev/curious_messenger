defmodule CuriousMessengerWeb.PageController do
  use CuriousMessengerWeb, :controller

  alias CuriousMessenger.Auth
  alias CuriousMessenger.Chat.Conversation

  plug CuriousMessengerWeb.AssignUser, preload: :conversations
  plug :assign_contacts

  def index(conn, opts \\ []) do
    render(conn, "index.html")
  end

  defp assign_contacts(conn, _params) do
    users = Auth.list_auth_users()

    conn
    |> assign(:contacts, users)
  end

  defp assign_new_conversation_changeset(conn, _params) do
    changeset = %Conversation{} |> Conversation.changeset(%{})

    conn
    |> assign(:conversation_changeset, changeset)
  end
end
