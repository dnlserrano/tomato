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
end
