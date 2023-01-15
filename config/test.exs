import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :personal_portfolio, PersonalPortfolio.Repo,
  username: "quentinlee",
  password: "postgres",
  hostname: "localhost",
  database: "personal_portfolio_dev",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :personal_portfolio, PersonalPortfolioWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nZEzZqvhj0StwJwzFZgHoPXCTRDb3snw7QY03J08ThDBxLYeyityQWUbhfnNs7pY",
  server: false

# In test we don't send emails.
config :personal_portfolio, PersonalPortfolio.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
