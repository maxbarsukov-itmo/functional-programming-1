defmodule NumberSpiralDiagonals.SimpleStream do
  @moduledoc "Naive realization by using streams and laziness"

  def sum_diagonals(size) do
    Stream.iterate({size, 1, 0, 0}, fn {current_size, current, step, sum} ->
      layer = div(current_size - 1, 2)

      new_sum =
        Stream.unfold((2 * layer + 1) * (2 * layer + 1), fn n -> {n, n - 2 * layer} end)
        |> Enum.take(4)
        |> Enum.sum()

      {current_size - 2, current + 4 * step + 1, step + 2, sum + new_sum}
    end)
    |> Stream.take_while(fn {current_size, _, _, _} -> current_size >= 1 end)
    |> Enum.reduce(1, fn {_, _, _, sum}, acc -> acc + sum end)
  end
end
