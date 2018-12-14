defmodule TomatoTest do
  import Mox
  use ExUnit.Case, async: true

  @subject Tomato

  @client Application.get_env(:tomato, :client)

  setup :verify_on_exit!

  describe "categories/0" do
    test "returns category objects" do
      stub(@client, :get, fn "categories" ->
        {:ok, %{categories: [
          %{categories: %{id: 1, name: "Category #1"}},
          %{categories: %{id: 2, name: "Category #2"}},
        ]}}
      end)

      {:ok, categories} = @subject.categories
      assert categories == [
        %Tomato.Category{id: 1, name: "Category #1"},
        %Tomato.Category{id: 2, name: "Category #2"},
      ]
    end
  end
end
