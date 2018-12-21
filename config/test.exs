use Mix.Config

config :tomato,
  client: Tomato.ClientMock,
  http_client: HTTPoisonMock,
  zomato_api_key: "z0m4t0-4p1-k3y",
  zomato_api_uri: "https://developers.zomato.com"
