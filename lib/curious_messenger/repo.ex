defmodule CuriousMessenger.Repo do
  use Ecto.Repo,
    otp_app: :curious_messenger,
    adapter: Ecto.Adapters.Postgres
end
