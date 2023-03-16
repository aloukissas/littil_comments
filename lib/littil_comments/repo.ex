defmodule LittilComments.Repo do
  use Ecto.Repo,
    otp_app: :littil_comments,
    adapter: Ecto.Adapters.Postgres
end
