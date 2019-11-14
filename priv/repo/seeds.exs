# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CuriousMessenger.Repo.insert!(%CuriousMessenger.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CuriousMessenger.Auth.User
alias CuriousMessenger.Chat.Conversation

alias CuriousMessenger.{Auth, Chat}

rand1 = Enum.random(0..1000)
rand2 = Enum.random(0..1000)

{:ok, %User{id: u1_id} = user1} =
  Auth.create_user(%{
    email: "user_#{rand1}@curiosum.dev",
    password: "p@55w0rd",
    confirm_password: "p@55w0rd",
    nickname: "User #{rand1}"
  })

{:ok, %User{id: u2_id} = user2} =
  Auth.create_user(%{
    email: "user_#{rand2}@curiosum.dev",
    password: "p@55w0rd",
    confirm_password: "p@55w0rd",
    nickname: "User #{rand2}"
  })

{:ok, %Conversation{id: conv_id} = conversation} =
  Chat.create_conversation(%{
    title: "Modern Talking",
    conversation_members: [%{user_id: u1_id, owner: true}, %{user_id: u2_id, owner: false}]
  })

IO.puts("Created records:")
IO.inspect(user1)
IO.inspect(user2)
IO.inspect(conversation)
