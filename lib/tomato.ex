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
        |> Map.get(:categories)
        |> Enum.map(fn(category) ->
          struct(Tomato.Category, category[:categories])
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
    with {:ok, response} <- @client.get("collections", query) do
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
    with {:ok, response} <- @client.get("cuisines", query) do
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
    with {:ok, response} <- @client.get("establishments", query) do
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

  @doc """
  Get location details based on coordinates
  """
  def geocode(lat, long) do
    query = %{lat: lat, long: long}

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
    query = %{res_id: id}

    with {:ok, response} <- @client.get("restaurant", query) do
      restaurant = map_restaurant(response)
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
        |> Map.get(:restaurants)
        |> Enum.map(fn(restaurant) ->
          map_restaurant(restaurant[:restaurant])
        end)

      {:ok, restaurants}
    else
      error -> error
    end
  end

  defp map_restaurant(restaurant_info) do
    location = map_location(restaurant_info)
    user_rating = map_user_rating(restaurant_info)

    restaurant = struct(Tomato.Restaurant, restaurant_info)
    restaurant = %{restaurant |
      location: location,
      user_rating: user_rating,
    }

    restaurant
  end

  defp map_location(restaurant_info) do
    struct(Tomato.Location, restaurant_info[:location])
  end

  defp map_user_rating(restaurant_info) do
    struct(Tomato.Rating, restaurant_info[:user_rating])
  end
end
