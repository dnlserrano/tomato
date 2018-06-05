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
  def cities(query) do
    with {:ok, response} <- Client.get("cities", query) do
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
  def collections(query) do
    with {:ok, response} <- Client.get("collections", query) do
      collections =
        response
        |> Map.get(:collections)
        |> Enum.map(fn(collection) ->
          struct(Tomato.Collection, collection[:collection])
          |> struct(id: collection[:collection][:collection_id])
        end)

      {:ok, collections}
    else
      error -> error
    end
  end

  @doc """
  Get list of all cuisines in a city
  """
  def cuisines(query) do
    with {:ok, response} <- Client.get("cuisines", query) do
      cuisines =
        response
        |> Map.get(:cuisines)
        |> Enum.map(fn(%{cuisine: cuisine}) ->
          struct(Tomato.Cuisine, %{
            id: cuisine[:cuisine_id],
            name: cuisine[:cuisine_name]
          })
        end)

      {:ok, cuisines}
    else
      error -> error
    end
  end

  @doc """
  Get list of restaurant types in a city
  """
  def establishments(query) do
    with {:ok, response} <- Client.get("establishments", query) do
      establishments =
        response
        |> Map.get(:establishments)
        |> Enum.map(fn(establishment) ->
          struct(Tomato.Establishment, establishment[:establishment])
        end)

      {:ok, establishments}
    else
      error -> error
    end
  end
end
