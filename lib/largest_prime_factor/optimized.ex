defmodule LargestPrimeFactor.Optimized do
  @moduledoc "Optimized realization"

  def wheel235(),
    do:
      Stream.concat(
        [2, 3, 5],
        Stream.scan(Stream.cycle([6, 4, 2, 4, 2, 4, 6, 2]), 1, &+/2)
      )

  def largest_prime_factor(n), do: largest_prime_factor(n, wheel235())

  defp largest_prime_factor(n, divs) do
    [d] = Enum.take(divs, 1)

    cond do
      d * d > n -> n
      rem(n, d) === 0 -> largest_prime_factor(div(n, d), divs)
      true -> largest_prime_factor(n, Stream.drop(divs, 1))
    end
  end
end
