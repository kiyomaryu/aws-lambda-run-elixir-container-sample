defmodule LambdaElixirSampleTest do
  use ExUnit.Case
  doctest LambdaElixirSample

  test "greets the world" do
    assert LambdaElixirSample.hello() == :world
  end
end
