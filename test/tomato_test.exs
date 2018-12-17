defmodule TomatoTest do
  import Mox
  use ExUnit.Case, async: true

  @subject Tomato

  @client Application.get_env(:tomato, :client)

  setup :verify_on_exit!

  describe "categories/0" do
    test "returns category objects" do
      stub(@client, :get, fn "categories" -> categories() end)

      {:ok, categories} = @subject.categories
      assert 13 == length(categories)
      assert "Delivery" == categories |> Enum.at(0) |> Map.get(:name)
      assert "Clubs & Lounges" == categories |> Enum.at(12) |> Map.get(:name)
    end
  end

  describe "cities/1" do
    test "returns city objects" do
      stub(@client, :get, fn "cities", %{city_ids: "82"} -> cities() end)

      {:ok, cities} = @subject.cities(%{city_ids: "82"})
      assert 1 == length(cities)
      assert "Greater Lisbon" == cities |> Enum.at(0) |> Map.get(:name)
    end
  end

  describe "collections/1" do
    test "returns collection objects" do
      stub(@client, :get, fn "collections", %{city_id: 82} -> collections() end)

      {:ok, collections} = @subject.collections(%{city_id: 82})
      assert 41 == length(collections)
      assert "Trending This Week" == collections |> Enum.at(0) |> Map.get(:title)
      assert "Sneak Peek" == collections |> Enum.at(40) |> Map.get(:title)
    end
  end

  describe "cuisines/1" do
    test "returns cuisine objects" do
      stub(@client, :get, fn "cuisines", %{city_id: 82} -> cuisines() end)

      {:ok, cuisines} = @subject.cuisines(%{city_id: 82})
      assert 103 == length(cuisines)
      assert "African" == cuisines |> Enum.at(0) |> Map.get(:name)
      assert "Vietnamese" == cuisines |> Enum.at(102) |> Map.get(:name)
    end
  end

  describe "establishments/1" do
    test "returns establishment objects" do
      stub(@client, :get, fn "establishments", %{city_id: 82} -> establishments() end)

      {:ok, establishments} = @subject.establishments(%{city_id: 82})
      assert 21 == length(establishments)
      assert "Snack Bar" == establishments |> Enum.at(0) |> Map.get(:name)
      assert "Beer Garden" == establishments |> Enum.at(20) |> Map.get(:name)
    end
  end

  describe "geocode/1" do
    test "returns geocode object" do
      raw_geocode = geocode()
      stub(@client, :get, fn "geocode", %{lat: 38.7337710000, long: -9.1448500000} ->
        raw_geocode
      end)

      assert raw_geocode == @subject.geocode(38.7337710000, -9.1448500000)
    end
  end

  defp categories(), do: read_json("test/resources/categories.json")
  defp cities(), do: read_json("test/resources/cities.json")
  defp collections(), do: read_json("test/resources/collections.json")
  defp cuisines(), do: read_json("test/resources/cuisines.json")
  defp establishments(), do: read_json("test/resources/establishments.json")
  defp geocode(), do: read_json("test/resources/geocode.json")

  defp read_json(path) do
    path
    |> File.read!()
    |> Poison.decode()
  end
end
