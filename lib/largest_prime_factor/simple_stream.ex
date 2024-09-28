defmodule LargestPrimeFactor.SimpleStream do
  @moduledoc "Naive realization by using streams and laziness"

  use LargestPrimeFactor.Concerns.Prime

  def largest_prime_factor(n) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&(rem(n, &1) == 0))
    |> Stream.filter(&prime?/1)
    |> Enum.take(1)
    |> List.first()
  end
end
