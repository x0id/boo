defmodule BooTest do
  use ExUnit.Case
  doctest Boo

  test "greets the world" do
    assert Boo.hello() == :world
  end
end
