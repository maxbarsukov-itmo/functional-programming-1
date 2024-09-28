defmodule LargestPrimeFactor.SimpleModular do
  @moduledoc "Realization by using modules (generate, filter, reduce + map)"

  defmodule SequenceGenerator do
    @moduledoc "Module-generator"

    @spec generate_sequence(pos_integer()) :: Range.t()
    def generate_sequence(n) when is_integer(n) and n > 1, do: 2..n
  end

  defmodule SequenceFilter do
    @moduledoc "Module-filter"

    use LargestPrimeFactor.Concerns.Prime

    @spec filter_sequence(list(), pos_integer()) :: list()
    def filter_sequence(sequence, n),
      do: sequence |> Stream.filter(&(rem(n, &1) == 0)) |> Enum.filter(&prime?/1)
  end

  defmodule SequenceMapper do
    @moduledoc "Module-mapper"

    @spec map_sequence(any()) :: any()
    def map_sequence(sequence), do: Enum.map(sequence, & &1)
  end

  defmodule SequenceReducer do
    @moduledoc "Module-reducer"

    @spec max(list()) :: pos_integer()
    def max(integer_sequence), do: Enum.reduce(integer_sequence, 1, &((&2 > &1 && &2) || &1))
  end

  @spec largest_prime_factor(pos_integer()) :: pos_integer()
  def largest_prime_factor(n) do
    SequenceGenerator.generate_sequence(n)
    |> SequenceMapper.map_sequence()
    |> SequenceFilter.filter_sequence(n)
    |> SequenceReducer.max()
  end
end
