defmodule CodingChallenge.Repo do
  use Ecto.Repo,
    otp_app: :coding_challenge,
    adapter: Ecto.Adapters.Postgres
end
