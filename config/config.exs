use Mix.Config

config :tomato,
  zomato_api_key: System.get_env("ZOMATO_API_KEY"),
  zomato_api_uri: System.get_env("ZOMATO_API_URI")

import_config "#{Mix.env()}.exs"
