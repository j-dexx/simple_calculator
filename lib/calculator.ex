defmodule Calculator do
  @moduledoc """
  Documentation for Calculator.
  """

  def start() do
    spawn(fn -> loop(0) end)
  end

  def add(pid, number) do
    send(pid, {:add, number})
  end

  def sub(pid, number) do
    send(pid, {:sub, number})
  end

  def mul(pid, number) do
    send(pid, {:mul, number})
  end

  def div(pid, number) do
    send(pid, {:div, number})
  end

  def value(pid) do
    send(pid, {:value, self()})
    receive do
      {:response, value} -> value
    end
  end

  defp loop(value) do
    new_value =
      receive do
        {:value, caller} ->
          send(caller, {:response, value})
          value

        {:add, number} -> value + number

        {:sub, number} -> value - number

        {:mul, number} -> value * number

        {:div, number} -> value / number

        invalid_request ->
          IO.puts("invalid request #{inspect(invalid_request)}")
      end

    loop(new_value)
  end
end
