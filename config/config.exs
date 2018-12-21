use Mix.Config

config :tomato,
  client: Tomato.Client,
  http_client: HTTPoison,
  zomato_api_key: System.get_env("ZOMATO_API_KEY"),
  zomato_api_uri: System.get_env("ZOMATO_API_URI")

import_config "#{Mix.env()}.exs"
