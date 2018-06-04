defmodule Tomato do
  @moduledoc """
  Documentation for Tomato.
  """

  alias Tomato.Client

  @doc """
  Get categories
  """
  def categories do
    with {:ok, response} <- Client.get("categories") do
      categories =
        response
        |> Map.get(:categories)
        |> Enum.map(fn(category) ->
          struct(Tomato.Category, category[:categories])
        end)

      {:ok, categories}
    else
      error -> error
    end
  end

  @doc """
  Get cities
  """
  def cities(%Tomato.Queries.City{} = city_query) do
    city_params = query_to_params(city_query)

    with {:ok, response} <- Client.get("cities", city_params) do
      cities =
        response
        |> Map.get(:location_suggestions)
        |> Enum.map(fn(city) ->
          struct(Tomato.City, city)
        end)

      {:ok, cities}
    else
      error -> error
    end
  end

  defp query_to_params(query) do
    query
    |> Map.from_struct
  end
end
