defmodule Tomato.Client do
  @user_key System.get_env("ZOMATO_API_KEY")
  @base_uri System.get_env("ZOMATO_API_URI")

  def get(path, parameters \\ %{}) do
    %HTTPoison.Response{body: body} =
      HTTPoison.get!(uri(path), add_user_key(parameters))

    Poison.decode!(body, keys: :atoms)
  end

  defp uri(path) do
    @base_uri
    |> URI.merge(path)
    |> URI.to_string()
  end

  defp add_user_key(parameters) do
    Map.put(parameters, :user_key, @user_key)
  end
end
