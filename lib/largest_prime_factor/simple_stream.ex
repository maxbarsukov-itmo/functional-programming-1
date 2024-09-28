defmodule LargestPrimeFactor.SimpleStream do
  @moduledoc "Naive realization by using streams and laziness"

  use LargestPrimeFactor.Concerns.Prime

  def largest_prime_factor(n) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&(rem(n, &1) == 0))
    |> Stream.filter(&prime?/1)
    |> Stream.filter(&(&1 < (prime?(n) && n || ceil(:math.sqrt(n)))))
    |> Enum.max()
  end
end
