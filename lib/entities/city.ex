defmodule Tomato.City do
  defstruct [
    :id, :name, :country_id, :country_name,
    :is_state, :state_id, :state_name, :state_code
  ]

  def from(%{
    "id" => id,
    "name" => name,
    "country_id" => country_id,
    "country_name" => country_name,
    "is_state" => is_state,
    "state_id" => state_id,
    "state_name" => state_name,
    "state_code" => state_code
  }) do
    %__MODULE__{
      id: id,
      name: name,
      country_id: country_id,
      country_name: country_name,
      is_state: is_state,
      state_id: state_id,
      state_name: state_name,
      state_code: state_code
    }
  end
end
