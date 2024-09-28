defmodule LargestPrimeFactor.AsyncTask do
  @moduledoc "Realization by using async tasks"

  use LargestPrimeFactor.Concerns.Prime

  def largest_prime_factor(n) do
    factors =
      2..trunc(:math.sqrt(n))
      |> Task.async_stream(fn i -> factorize(n, i) end, max_concurrency: 8)
      |> Enum.filter(fn {_, num} -> num != nil end)
      |> Enum.map(fn {_, num} -> num end)

    if factors == [] do
      n
    else
      Enum.max(factors)
    end
  end

  defp factorize(n, i) when rem(n, i) == 0 do
    if prime?(i), do: i, else: nil
  end

  defp factorize(_, _), do: nil
end
