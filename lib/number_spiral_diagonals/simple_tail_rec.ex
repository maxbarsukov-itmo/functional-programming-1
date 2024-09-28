defmodule NumberSpiralDiagonals.SimpleTailRec do
  @moduledoc "Naive realization by using tail recursion"

  def sum_diagonals(size) do
    sum_diagonals(size, 1, 0, 0)
  end

  defp sum_diagonals(1, _, sum, _), do: sum + 1

  defp sum_diagonals(size, current, sum, step) do
    layer = div(size - 1, 2)

    new_sum =
      Stream.unfold((2 * layer + 1) * (2 * layer + 1), fn n -> {n, n - 2 * layer} end)
      |> Enum.take(4)
      |> Enum.sum()

    sum_diagonals(size - 2, current + 4 * step + 1, sum + new_sum, step + 2)
  end
end
