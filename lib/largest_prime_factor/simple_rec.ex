defmodule LargestPrimeFactor.SimpleRec do
  @moduledoc "Realization by using regular recursion"

  def largest_prime_factor(n) do
    n |> factorize(2) |> Enum.max()
  end

  defp factorize(1, _factor), do: []

  defp factorize(n, factor) when rem(n, factor) == 0 do
    [factor | factorize(div(n, factor), factor)]
  end

  defp factorize(n, factor) when factor * factor <= n do
    factorize(n, factor + 1)
  end

  defp factorize(n, _factor), do: [n]
end
