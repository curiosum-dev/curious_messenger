defmodule CuriousMessenger.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias CuriousMessenger.Auth.User
  alias CuriousMessenger.Chat.{Conversation, SeenMessage, MessageReaction}

  schema "chat_messages" do
    field :content, :string

    belongs_to :conversation, Conversation
    belongs_to :user, User

    has_many :seen_messages, SeenMessage
    has_many :message_reactions, MessageReaction

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :conversation_id, :user_id])
    |> validate_required([:content, :conversation_id, :user_id])
  end
end
