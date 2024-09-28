defmodule NumberSpiralDiagonals.AsyncTask do
  @moduledoc "Realization by using async tasks"

  def sum_diagonals(1), do: 1

  def sum_diagonals(size) do
    1 +
      (3..(div(size, 2) * 2 + 1)
       |> Enum.filter(&(rem(&1, 2) == 1))
       |> Task.async_stream(fn n -> 4 * n * n - 6 * (n - 1) end, max_concurrency: 8)
       |> Enum.reduce(0, fn {:ok, sum}, acc -> acc + sum end))
  end
end
