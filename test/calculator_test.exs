defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "is a working calculator" do
    pid = Calculator.start()
    Calculator.add(pid, 4)
    Calculator.mul(pid, 5)
    Calculator.sub(pid, 2)
    Calculator.div(pid, 2)

    assert 9 == Calculator.value(pid)
  end
end
