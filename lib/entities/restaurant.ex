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
end
