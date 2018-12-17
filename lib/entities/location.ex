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

  def from(%{
    "address" => address,
    "locality" => locality,
    "city" => city,
    "latitude" => latitude,
    "longitude" => longitude,
    "zipcode" => zipcode,
    "country_id" => country_id
  }) do
    %__MODULE__{
      address: address,
      locality: locality,
      city: city,
      latitude: latitude,
      longitude: longitude,
      zipcode: zipcode,
      country_id: country_id
    }
  end
end
