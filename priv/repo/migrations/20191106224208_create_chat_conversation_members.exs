defmodule CuriousMessenger.Repo.Migrations.CreateChatConversationMembers do
  use Ecto.Migration

  def change do
    create table(:chat_conversation_members) do
      add :owner, :boolean, default: false, null: false
      add :conversation_id, references(:chat_conversations, on_delete: :nothing), null: false
      add :user_id, references(:auth_users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:chat_conversation_members, [:conversation_id])
    create index(:chat_conversation_members, [:user_id])
    create unique_index(:chat_conversation_members, [:conversation_id, :user_id])

    create unique_index(:chat_conversation_members, [:conversation_id],
             where: "owner = TRUE",
             name: "chat_conversation_members_owner"
           )
  end
end
