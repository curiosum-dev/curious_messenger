defmodule CuriousMessengerWeb.ConversationController do
  use CuriousMessengerWeb, :controller

  alias CuriousMessenger.Chat

  require IEx

  plug CuriousMessengerWeb.AssignUser

  def create(conn, %{"conversation" => params}) do
    # case Chat.create_conversation(%{params})
  end
end
