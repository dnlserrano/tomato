defmodule Tomato do
  @moduledoc """
  Documentation for Tomato.
  """

  alias Tomato.Client

  @doc """
  Get list of categories
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
  Get city details
  """
  def cities(%Tomato.Queries.Cities{} = cities_query) do
    params = query_to_params(cities_query)

    with {:ok, response} <- Client.get("cities", params) do
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

  @doc """
  Get collections in a city
  """
  def collections(%Tomato.Queries.Collections{} = collections_query) do
    params = query_to_params(collections_query)

    with {:ok, response} <- Client.get("collections", params) do
      collections =
        response
        |> Map.get(:collections)
        |> Enum.map(fn(collection) ->
          struct(Tomato.Collection, collection[:collection])
        end)

      {:ok, collections}
    else
      error -> error
    end
  end

  defp query_to_params(query) do
    query
    |> Map.from_struct
  end
end
