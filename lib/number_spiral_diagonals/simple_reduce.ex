defmodule NumberSpiralDiagonals.SimpleReduce do
  @moduledoc "Naive realization by using reducing by diagonals"

  def sum_diagonals(1), do: 1

  def sum_diagonals(size) do
    1 +
      Enum.reduce(3..(div(size, 2) * 2 + 1) |> Enum.filter(&(rem(&1, 2) == 1)), 0, fn n, acc ->
        acc + 4 * n * n - 6 * (n - 1)
      end)
  end
end
