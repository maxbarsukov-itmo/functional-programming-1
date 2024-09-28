defmodule NumberSpiralDiagonals.Math do
  @moduledoc "Realization by using just a formula"

  def sum_diagonals(size) do
    div(size * (size * (4 * size + 3) + 8) - 9, 6)
  end
end
