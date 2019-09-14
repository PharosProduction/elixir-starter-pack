defmodule CategoriesTest do
  use ExUnit.Case
  doctest Categories

  test "greets the world" do
    assert Categories.hello() == :world
  end
end
