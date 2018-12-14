use Mix.Config

config :tomato, client: Tomato.Client

import_config "#{Mix.env()}.exs"
