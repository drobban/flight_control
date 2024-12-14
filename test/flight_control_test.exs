defmodule FlightControlTest do
  use ExUnit.Case
  doctest FlightControl

  test "greets the world" do
    assert FlightControl.hello() == :world
  end
end
