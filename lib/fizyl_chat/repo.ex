defmodule FizylChat.Repo do
  use Ecto.Repo,
    otp_app: :fizyl_chat,
    adapter: Ecto.Adapters.Postgres
end
