import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :littil_comments, LittilComments.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "littil_comments_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :littil_comments, LittilCommentsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2uc3wVCOA6Lbdu/VpAiB3s2pYot+F2e7NxExdv+spUPsN3dNwJdSJSew6nPpE3J6",
  server: false

# In test we don't send emails.
config :littil_comments, LittilComments.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
