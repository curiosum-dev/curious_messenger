defmodule CuriousMessenger.Chat.ConversationMember do
  use Ecto.Schema
  import Ecto.Changeset

  alias CuriousMessenger.Auth.User
  alias CuriousMessenger.Chat.Conversation

  schema "chat_conversation_members" do
    field :owner, :boolean, default: false

    belongs_to :user, User
    belongs_to :conversation, Conversation

    timestamps()
  end

  @doc false
  def changeset(conversation_member, attrs) do
    conversation_member
    |> cast(attrs, [:owner, :conversation_id, :user_id])
    |> validate_required([:owner, :conversation_id, :user_id])
    |> unique_constraint(:user, name: :chat_conversation_members_conversation_id_user_id_index)
    |> unique_constraint(:conversation_id,
      name: :chat_conversation_members_owner
    )
  end
end
