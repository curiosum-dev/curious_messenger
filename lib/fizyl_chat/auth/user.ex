defmodule FizylChat.Auth.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  import Ecto.Changeset

  alias FizylChat.Chat.{ConversationMember}

  schema "auth_users" do
    pow_user_fields()

    field :nickname, :string

    has_many :conversation_members, ConversationMember
    has_many :conversations, through: [:conversation_members, :conversation]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:nickname])
    |> validate_required([:nickname])
    |> unique_constraint(:nickname)
  end
end
