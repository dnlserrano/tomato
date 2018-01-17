defmodule Tomato do
  alias Tomato.Client
  @moduledoc """
  Documentation for Tomato.
  """

  @doc """
  Get categories
  """
  def categories do
    Client.get("categories")[:categories]
    |> Enum.map(fn(category) ->
      struct(Tomato.Category, category[:categories])
    end)
  end

  def cities(city_query) do
    city_params = city_query |> Map.delete(:__struct__)
    Client.get("cities", city_params)[:location_suggestions]
    |> Enum.map(fn(city) ->
      struct(Tomato.City, city[:cities])
    end)
  end
end
