defmodule Tomato.Collection do
  defstruct [
    :id, :title, :url, :description,
    :image_url, :res_count, :share_url
  ]

  def from(%{
    "collection_id" => id,
    "title" => title,
    "url" => url,
    "description" => description,
    "image_url" => image_url,
    "res_count" => res_count,
    "share_url" => share_url
  }) do
    %__MODULE__{
      id: id,
      title: title,
      url: url,
      description: description,
      image_url: image_url,
      res_count: res_count,
      share_url: share_url
    }
  end
end
