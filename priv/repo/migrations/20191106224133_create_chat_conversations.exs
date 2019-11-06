defmodule CuriousMessenger.Repo.Migrations.CreateChatConversations do
  use Ecto.Migration

  def change do
    create table(:chat_conversations) do
      add :title, :string, null: false

      timestamps()
    end
  end
end
