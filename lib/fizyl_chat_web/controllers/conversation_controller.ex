defmodule FizylChatWeb.ConversationController do
  use FizylChatWeb, :controller

  alias FizylChat.Chat

  require IEx

  plug FizylChatWeb.AssignUser

  def create(conn, %{"conversation" => params}) do
    # case Chat.create_conversation(%{params})
  end
end
