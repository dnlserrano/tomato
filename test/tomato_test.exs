defmodule TomatoTest do
  use ExUnit.Case
  doctest Tomato

  test "greets the world" do
    assert Tomato.hello() == :world
  end
end
