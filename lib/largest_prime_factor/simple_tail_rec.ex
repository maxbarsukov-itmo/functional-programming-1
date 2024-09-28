defmodule LargestPrimeFactor.SimpleTailRec do
  @moduledoc "Naive realization by using tail recursion"

  def largest_prime_factor(n) do
    largest_prime_factor(n, 2)
  end

  defp largest_prime_factor(1, largest_factor), do: largest_factor

  defp largest_prime_factor(n, factor) when rem(n, factor) == 0 do
    largest_prime_factor(div(n, factor), factor)
  end

  defp largest_prime_factor(n, factor) do
    largest_prime_factor(n, factor + 1)
  end
end
