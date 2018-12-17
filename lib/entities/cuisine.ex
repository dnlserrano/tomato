defmodule Tomato.Cuisine do
  defstruct [:id, :name]

  def from(%{
    "cuisine_id" => id,
    "cuisine_name" => name
  }) do
    %__MODULE__{
      id: id,
      name: name
    }
  end
end
