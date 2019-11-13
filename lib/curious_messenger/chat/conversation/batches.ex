defmodule CuriousMessenger.Chat.Conversation.Batches do
  alias Ecto.{Multi, Changeset}
  alias CuriousMessenger.Chat.{Conversation}

  def create_conversation_with_members(attrs \\ %{}, member_attrs \\ []) do
    Multi.new()
    |> Multi.run(:create_conversation, create_conversation(attrs))
    |> Multi.run(:create_conversation_members, create_conversation_members(member_attrs))
  end

  defp create_conversation(attrs) do
    fn repo, _ ->
      %Conversation{}
      |> Conversation.changeset(attrs)
      |> repo.insert()
    end
  end

  defp create_conversation_members(member_attrs) do
    fn repo, %{create_conversation: conversation} ->
      member_attrs =
        Enum.map(member_attrs, fn member -> %{member | conversation_id: conversation.id} end)

      %{conversation | conversation_members: []}
      |> Conversation.changeset(%{})
      |> Changeset.put_assoc(:conversation_members, member_attrs)
      |> repo.update
    end
  end
end
