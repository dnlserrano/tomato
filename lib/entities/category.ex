defmodule Tomato.Category do
  defstruct [:id, :name]

  def from(%{"id" => id, "name" => name}) do
    %__MODULE__{
      id: id,
      name: name
    }
  end
end
