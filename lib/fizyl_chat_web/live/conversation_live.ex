defmodule FizylChatWeb.ConversationLive do
  require Logger

  use Phoenix.LiveView, layout: {FizylChatWeb.LayoutView, "live.html"}
  use Phoenix.HTML

  alias FizylChat.{Auth, Chat, Repo}
  alias FizylChatWeb.ConversationView

  def render(assigns) do
    ConversationView.render("show.html", assigns)
  end

  def mount(assigns, socket) do
    {:ok, socket}
  end

  def handle_event(
        "send_message",
        %{"message" => %{"content" => content}},
        %{assigns: %{conversation_id: conversation_id, user_id: user_id, user: user}} = socket
      ) do
    case Chat.create_message(%{
           conversation_id: conversation_id,
           user_id: user_id,
           content: content
         }) do
      {:ok, new_message} ->
        new_message = %{new_message | user: user}

        FizylChatWeb.Endpoint.broadcast!(
          "conversation_#{conversation_id}",
          "new_message",
          new_message
        )

      {:error, err} ->
        Logger.error(inspect(err))
    end

    {:noreply, socket}
  end

  def handle_params(%{"conversation_id" => conversation_id, "user_id" => user_id}, _uri, socket) do
    FizylChatWeb.Endpoint.subscribe("conversation_#{conversation_id}")

    {:noreply,
     socket
     |> assign(:user_id, user_id)
     |> assign(:conversation_id, conversation_id)
     |> assign_records()}
  end

  def handle_info(%{event: "new_message", payload: new_message}, socket) do
    annotated_message =
      if new_message.user.id != socket.assigns[:user].id do
        new_message |> Map.put(:incoming, true)
      else
        new_message
      end

    updated_messages = socket.assigns[:messages] ++ [annotated_message]

    {:noreply, socket |> assign(:messages, updated_messages)}
  end

  defp assign_records(%{assigns: %{user_id: user_id, conversation_id: conversation_id}} = socket) do
    user = Auth.get_user!(user_id)

    conversation =
      Chat.get_conversation!(conversation_id)
      |> Repo.preload(messages: [:user], conversation_members: [:user])

    socket
    |> assign(:user, user)
    |> assign(:conversation, conversation)
    |> assign(:messages, conversation.messages)
  end
end
