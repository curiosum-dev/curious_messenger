defmodule CuriousMessenger.Chat.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  alias CuriousMessenger.Chat.{ConversationMember, Message}

  schema "chat_conversations" do
    field :title, :string

    has_many :conversation_members, ConversationMember, on_replace: :delete
    has_many :users, through: [:conversation_members, :user]
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:title])
    |> cast_assoc(:conversation_members)
    |> validate_required([:title])
  end
end
