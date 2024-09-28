defmodule LargestPrimeFactor.SimpleMap do
  @moduledoc "Naive realization by just filtering and mapping"

  use LargestPrimeFactor.Concerns.Prime

  def largest_prime_factor(n) do
    2..n
    |> Enum.filter(&(rem(n, &1) == 0))
    |> Enum.map(&factor_prime/1)
    |> Enum.max()
  end

  defp factor_prime(factor) do
    if prime?(factor), do: factor, else: 0
  end
end
