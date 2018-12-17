defmodule Tomato.Restaurant do
  defstruct [
    :id,
    :name,
    :url,
    :location,
    :average_cost_for_two,
    :price_range,
    :currency,
    :thumb,
    :featured_image,
    :photos_url,
    :menu_url,
    :events_url,
    :user_rating,
    :has_online_delivery,
    :is_delivering_now,
    :has_table_booking,
    :deeplink,
    :cuisines,
  ]

  def from(%{
    "id" => id,
    "name" => name,
    "url" => url,
    "location" => location,
    "average_cost_for_two" => average_cost_for_two,
    "price_range" => price_range,
    "currency" => currency,
    "thumb" => thumb,
    "featured_image" => featured_image,
    "photos_url" => photos_url,
    "menu_url" => menu_url,
    "events_url" => events_url,
    "user_rating" => user_rating,
    "has_online_delivery" => has_online_delivery,
    "is_delivering_now" => is_delivering_now,
    "has_table_booking" => has_table_booking,
    "deeplink" => deeplink,
    "cuisines" => cuisines
  }) do
    %__MODULE__{
      id: id,
      name: name,
      url: url,
      location: Tomato.Location.from(location),
      average_cost_for_two: average_cost_for_two,
      price_range: price_range,
      currency: currency,
      thumb: thumb,
      featured_image: featured_image,
      photos_url: photos_url,
      menu_url: menu_url,
      events_url: events_url,
      user_rating: Tomato.Rating.from(user_rating),
      has_online_delivery: has_online_delivery,
      is_delivering_now: is_delivering_now,
      has_table_booking: has_table_booking,
      deeplink: deeplink,
      cuisines: map_cuisines(cuisines)
    }
  end

  defp map_cuisines(cuisines) do
    cuisines
    |> Enum.map(fn cuisine ->
      Tomato.Cuisine.from(cuisine)
    end)
  end
end
