defmodule Tomato.Rating do
  defstruct [
    :aggregate_rating,
    :rating_text,
    :rating_color,
    :votes,
  ]

  def from(%{
    "aggregate_rating" => aggregate_rating,
    "rating_text" => rating_text,
    "rating_color" => rating_color,
    "votes" => votes
  }) do
    %__MODULE__{
      aggregate_rating: aggregate_rating,
      rating_text: rating_text,
      rating_color: rating_color,
      votes: votes
    }
  end
end
