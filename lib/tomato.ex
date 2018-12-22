defmodule Tomato do
  @moduledoc """
  Documentation for Tomato.
  """

  @client Application.get_env(:tomato, :client)

  @doc """
  Get list of categories
  """
  def categories do
    with {:ok, response} <- @client.get("categories") do
      categories =
        response
        |> Map.get("categories")
        |> Enum.map(fn(category) ->
          Tomato.Category.from(category["categories"])
        end)

      {:ok, categories}
    else
      error -> {:error, error}
    end
  end

  @doc """
  Get city details
  """
  def cities(query) do
    with {:ok, response} <- @client.get("cities", query) do
      cities =
        response
        |> Map.get("location_suggestions")
        |> Enum.map(fn(city) ->
          Tomato.City.from(city)
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
    with {:ok, response} <- @client.get("collections", query) do
      collections =
        response
        |> Map.get("collections")
        |> Enum.map(fn(collection) ->
          Tomato.Collection.from(collection["collection"])
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
    with {:ok, response} <- @client.get("cuisines", query) do
      cuisines =
        response
        |> Map.get("cuisines")
        |> Enum.map(fn(%{"cuisine" => cuisine}) ->
          Tomato.Cuisine.from(cuisine)
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
    with {:ok, response} <- @client.get("establishments", query) do
      establishments =
        response
        |> Map.get("establishments")
        |> Enum.map(fn(establishment) ->
          Tomato.Establishment.from(establishment["establishment"])
        end)

      {:ok, establishments}
    else
      error -> error
    end
  end

  @doc """
  Get location details based on coordinates
  """
  def geocode(lat, long) do
    query = [lat: lat, lon: long]

    with {:ok, response} <- @client.get("geocode", query) do
      geo_info = response
      {:ok, geo_info}
    else
      error -> error
    end
  end

  @doc """
  Get restaurant details
  """
  def restaurant(id) do
    query = [res_id: id]

    with {:ok, response} <- @client.get("restaurant", query) do
      restaurant = Tomato.Restaurant.from(response)
      {:ok, restaurant}
    else
      error -> error
    end
  end

  @doc """
  Get restaurants matching given search criteria
  """
  def search(query) do
    with {:ok, response} <- @client.get("search", query) do
      restaurants =
        response
        |> Map.get("restaurants")
        |> Enum.map(fn(restaurant) ->
          Tomato.Restaurant.from(restaurant["restaurant"])
        end)

      {:ok, restaurants}
    else
      error -> error
    end
  end
end
