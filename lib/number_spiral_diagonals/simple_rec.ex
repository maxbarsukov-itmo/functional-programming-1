defmodule NumberSpiralDiagonals.SimpleRec do
  @moduledoc "Realization by using regular recursion"

  def sum_diagonals(n) when rem(n, 2) == 1 do
    sum_diagonals(n, 1)
  end

  defp sum_diagonals(1, sum), do: sum

  defp sum_diagonals(n, sum) do
    layer = div(n - 1, 2)
    top_right = (2 * layer + 1) * (2 * layer + 1)
    top_left = top_right - 2 * layer
    bottom_left = top_left - 2 * layer
    bottom_right = bottom_left - 2 * layer

    sum_diagonals(n - 2, sum + top_right + top_left + bottom_left + bottom_right)
  end
end
