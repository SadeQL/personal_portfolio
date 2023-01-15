defmodule PersonalPortfolio.Repo do
  use Ecto.Repo,
    otp_app: :personal_portfolio,
    adapter: Ecto.Adapters.Postgres
end
