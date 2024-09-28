defmodule LargestPrimeFactor.OptimizedStream do
  @moduledoc "Optimized realization with streams"

  # Генерация бесконечного потока простых чисел
  def prime_stream do
    Stream.unfold(2, fn candidate ->
      {
        (Enum.all?(2..(:math.sqrt(candidate) |> ceil()), fn p -> rem(candidate, p) != 0 end) &&
           candidate) || nil,
        candidate + 1
      }
    end)
    |> Stream.filter(&(&1 != nil))
  end

  # Функция для нахождения наибольшего простого множителя
  def largest_prime_factor(number) do
    prime_stream()
    # Фильтруем простые делители
    |> Stream.filter(fn prime -> rem(number, prime) == 0 end)
    |> Enum.reduce_while(number, fn prime, remainder ->
      new_remainder = reduce_remainder(remainder, prime)

      if new_remainder == 1 do
        # Останавливаем, если остаток равен 1
        {:halt, prime}
      else
        # Продолжаем делить
        {:cont, new_remainder}
      end
    end)
  end

  # Вспомогательная функция для сокращения остатка
  defp reduce_remainder(remainder, prime) do
    if rem(remainder, prime) == 0 do
      reduce_remainder(div(remainder, prime), prime)
    else
      remainder
    end
  end
end
