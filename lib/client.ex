defmodule Tomato.Client do
  def get(path, parameters \\ %{}) do
    {:ok, %HTTPoison.Response{status_code: status_code, body: body}} =
      HTTPoison.get(uri(path), headers(), options(parameters))

    case status_code < 300 do
      true -> {:ok, Poison.decode!(body, keys: :atoms)}
      false -> {:error, Poison.decode!(body, keys: :atoms)}
    end
  end

  defp uri(path) do
    api_uri()
    |> URI.merge(path)
    |> URI.to_string()
  end

  defp headers() do
    [
      {"Accept", "application/json"},
      {"X-Zomato-API-Key", api_key()}
    ]
  end

  defp options(parameters) do
    query_params = build_query_params(parameters)

    [
      params: query_params
    ]
  end

  defp build_query_params(parameters) do
    :maps.filter(fn _, v -> v != nil && v != "" end, parameters)
    |> Map.to_list
  end

  defp api_key, do: System.get_env("ZOMATO_API_KEY")
  defp api_uri, do: System.get_env("ZOMATO_API_URI")
end
