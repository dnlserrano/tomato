defmodule Tomato do
  @moduledoc """
  Documentation for Tomato.
  """

  @client Application.get_env(:tomato, :client) || Tomato.Client

  @doc """
  Get list of categories

      iex> Tomato.categories()
      {:ok,
       [
         %Tomato.Category{id: 1, name: "Delivery"},
         %Tomato.Category{id: 2, name: "Dine-out"},
         %Tomato.Category{id: 3, name: "Nightlife"},
         ...
       ]}
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

      iex> Tomato.cities(%{q: "Lisbon"})
      {:ok,
       [
         %Tomato.City{
           country_id: 164,
           country_name: "Portugal",
           id: 82,
           is_state: 0,
           name: "Greater Lisbon",
           state_code: "",
           state_id: 0,
           state_name: ""
         },
         ...
       ]}
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

      iex> Tomato.collections(%{city_id: 82})
      {:ok,
       [
         %Tomato.Collection{
           description: "The best new places in town",
           id: 29,
           image_url: "https://b.zmtcdn.com/data/collections/957133b8ebf50487c00cbadea54d6461_1516725996.jpg",
           res_count: 26,
           share_url: "http://www.zoma.to/c-82/29",
           title: "Newly Opened",
           url: "https://www.zomato.com/grande-lisboa/best-new-restaurants?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1"
         },
         ...
       ]}
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

      iex> Tomato.cuisines(%{city_id: 82})
      {:ok,
       [
         %Tomato.Cuisine{id: 152, name: "African"},
         %Tomato.Cuisine{id: 283, name: "Alentejana"},
         %Tomato.Cuisine{id: 1, name: "American"},
         ...
       ]}
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

      iex> Tomato.establishments(%{city_id: 82})
      {:ok,
       [
         %Tomato.Establishment{id: 241, name: "Snack Bar"},
         %Tomato.Establishment{id: 16, name: "Casual Dining"},
         %Tomato.Establishment{id: 278, name: "Wine Bar"},
         ...
       ]}
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

      iex> Tomato.geocode(38.733563, -9.144688)
      {:ok,
       %{
         "link" => "https://www.zomato.com/grande-lisboa/saldanha-restaurants",
         "location" => %{
           "city_id" => 82,
           "city_name" => "Greater Lisbon",
           "country_id" => 164,
           "country_name" => "Portugal",
           "entity_id" => 82041,
           "entity_type" => "subzone",
           "latitude" => "38.7337710000",
           "longitude" => "-9.1448500000",
           "title" => "Saldanha"
         },
         "nearby_restaurants" => [
           %{
             "restaurant" => %{
               ...
             }
           },
           ...
         ],
         ...
       }}
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

      iex> Tomato.restaurant(18714697)
      {:ok,
       %Tomato.Restaurant{
         average_cost_for_two: 30,
         cuisines: "Pizza",
         currency: "€",
         deeplink: "zomato://restaurant/18714697",
         events_url: "https://www.zomato.com/grande-lisboa/valdo-gatti-bairro-alto-lisboa/events#tabtop?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
         featured_image: "https://b.zmtcdn.com/data/pictures/7/18714697/2d7c3dbbb17e70490e68f0db2fba5c29.jpg",
         has_online_delivery: 0,
         has_table_booking: 0,
         id: "18714697",
         is_delivering_now: 0,
         location: %Tomato.Location{
           address: "Rua do Grémio Lusitano, 13, Bairro Alto, Lisboa",
           city: "Lisboa",
           country_id: 164,
           latitude: "38.7133620825",
           locality: "Bairro Alto",
           longitude: "-9.1440753266",
           zipcode: ""
         },
         menu_url: "https://www.zomato.com/grande-lisboa/valdo-gatti-bairro-alto-lisboa/menu?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1&openSwipeBox=menu&showMinimal=1#tabtop",
         name: "Valdo Gatti",
         photos_url: "https://www.zomato.com/grande-lisboa/valdo-gatti-bairro-alto-lisboa/photos?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1#tabtop",
         price_range: 3,
         thumb: "https://b.zmtcdn.com/data/pictures/7/18714697/2d7c3dbbb17e70490e68f0db2fba5c29.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
         url: "https://www.zomato.com/grande-lisboa/valdo-gatti-bairro-alto-lisboa?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
         user_rating: %Tomato.Rating{
           aggregate_rating: "4.5",
           rating_color: "3F7E00",
           rating_text: "Excellent",
           votes: "124"
         }
       }}
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

      iex> Tomato.search(%{entity_type: "city", entity_id: 82, start: 0, count: 5, cuisines: "82", sort: "rating", order: "desc"})
      {:ok,
       [
         %Tomato.Restaurant{
           average_cost_for_two: 50,
           cuisines: "Pizza, Italian",
           currency: "€",
           deeplink: "zomato://restaurant/8212322",
           ...
         },
         ...
       ]}
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
