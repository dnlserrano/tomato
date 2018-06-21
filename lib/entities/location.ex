defmodule Tomato.Location do
  defstruct [
    :address,
    :locality,
    :city,
    :latitude,
    :longitude,
    :zipcode,
    :country_id,
  ]
end
