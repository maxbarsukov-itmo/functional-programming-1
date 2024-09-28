defmodule NumberSpiralDiagonals.SimpleModular do
  @moduledoc "Realization by using modules (generate, filter, reduce + map)"

  defmodule SequenceGenerator do
    @moduledoc "Module-generator"

    @spec generate_sequence(pos_integer()) :: Range.t()
    def generate_sequence(n) when is_integer(n) and n > 1, do: 1..n
  end

  defmodule SequenceFilter do
    @moduledoc "Module-filter"

    @spec filter_sequence(any()) :: any()
    def filter_sequence(sequence), do: sequence |> Stream.filter(&(rem(&1, 2) == 1))
  end

  defmodule SequenceMapper do
    @moduledoc "Module-mapper"

    @spec map_sequence(any()) :: any()
    def map_sequence(sequence), do: sequence |> Stream.map(&diagonal_sum/1)

    defp diagonal_sum(1), do: 1

    defp diagonal_sum(size) do
      Stream.unfold(size * size, fn n -> {n, n - (size - 1)} end) |> Enum.take(4) |> Enum.sum()
    end
  end

  defmodule SequenceReducer do
    @moduledoc "Module-reducer"

    @spec reduce(any()) :: pos_integer()
    def reduce(sequence), do: sequence |> Enum.reduce(&(&1 + &2))
  end

  @spec sum_diagonals(1) :: 1
  def sum_diagonals(1), do: 1

  @spec sum_diagonals(pos_integer()) :: pos_integer()
  def sum_diagonals(n) when is_integer(n) and n > 0 do
    SequenceGenerator.generate_sequence(n)
    |> SequenceFilter.filter_sequence()
    |> SequenceMapper.map_sequence()
    |> SequenceReducer.reduce()
  end
end
