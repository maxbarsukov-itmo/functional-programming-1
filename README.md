# Лабораторная работа 1

[![Elixir](https://github.com/maxbarsukov-itmo/functional-programming-1/actions/workflows/elixir.yml/badge.svg?branch=master)](https://github.com/maxbarsukov-itmo/functional-programming-1/actions/workflows/elixir.yml)
[![Markdown](https://github.com/maxbarsukov-itmo/functional-programming-1/actions/workflows/markdown.yml/badge.svg?branch=master)](https://github.com/maxbarsukov-itmo/functional-programming-1/actions/workflows/markdown.yml)
[![Coverage Status](https://coveralls.io/repos/github/maxbarsukov-itmo/functional-programming-1/badge.svg?branch=master)](https://coveralls.io/github/maxbarsukov-itmo/functional-programming-1?branch=master)

## Проект Эйлера №3, №28

<img alt="lucky-star-konata" src="./.resources/anime.gif" height="180">

> Now I will have less distraction.
>
> — Leonhard Euler (Upon losing the use of his right eye; as quoted in In Mathematical Circles (1969) by H. Eves)

---

  * Студент: `Барсуков Максим Андреевич`
  * Группа: `P3315`
  * ИСУ: `367081`
  * Функциональный язык: `Elixir`

---

## Проблема №3

  * **Название**: `Largest Prime Factor`
  * **Описание**: The prime factors of $13195$ are $5$, $7$, $13$ and $29$.
  * **Задание**: What is the largest prime factor of the number $600851475143$?

---

### Основная идея решения

В целом, в разных решениях попробуем как решать наивным перебором, так и пытаться оптимизировать решение. Например, с помощью, [Wheel Factorization](https://en.wikipedia.org/wiki/Wheel_factorization), или просто ограничить перебор тем, что проверять будем только нечётные числа до $\sqrt n$.

---

### Решение через рекурсию

```elixir
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
```

### Решение через хвостовую рекурсию 

```elixir
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
```

### Решение через модульность (reduce, filter, map)

```elixir
defmodule LargestPrimeFactor.SimpleModular do
  defmodule SequenceGenerator do
    def generate_sequence(n) when is_integer(n) and n > 1, do: 2..n
  end

  defmodule SequenceFilter do
    use LargestPrimeFactor.Concerns.Prime

    def filter_sequence(sequence, n),
      do: sequence |> Stream.filter(&(rem(n, &1) == 0)) |> Enum.filter(&prime?/1)
  end

  defmodule SequenceMapper do
    def map_sequence(sequence), do: Enum.map(sequence, & &1)
  end

  defmodule SequenceReducer do
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
```

### Решение через бесконечные структуры и ленивые исполнения (Stream)

```elixir
  use LargestPrimeFactor.Concerns.Prime

  def largest_prime_factor(n) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&(rem(n, &1) == 0))
    |> Stream.filter(&prime?/1)
    |> Stream.filter(&(&1 < ((prime?(n) && n) || ceil(:math.sqrt(n)))))
    |> Enum.max()
  end
```

### Решение через императивный язык (C)

```c
#include <stdio.h>
#include <assert.h>

int is_prime(long long num) {
    if (num <= 1) return 0;
    for (long long i = 2; i * i <= num; i++) {
        if (num % i == 0) return 0;
    }
    return 1;
}

long long largest_prime_factor(long long num) {
    long long i;
    for (i = 2; i * i <= num; i++) {
        if (num % i == 0 && is_prime(i)) {
            num /= i;
            i--;
        }
    }
    return num;
}

int main() {
    long long num = 600851475143;
    long long largest_factor = largest_prime_factor(num);

    printf("The largest prime factor of %lld is %lld\n", num, largest_factor);
    assert(largest_factor == 6857);

    return 0;
}
```

---

## Проблема №28

  * **Название**: `Number Spiral Diagonals`
  * **Описание**: Starting with the number $1$ and moving to the right in a clockwise direction a $5$ by $5$ spiral is formed as follows. It can be verified that the sum of the numbers on the diagonals is $101$.

  ```txt
  21 22 23 24 25
  20  7  8  9 10
  19  6  1  2 11
  18  5  4  3 12
  17 16 15 14 13
  ```

  * **Задание**: What is the sum of the numbers on the diagonals in a $1001$ by $1001$ spiral formed in the same way?

---

### Основная идея решения

Эту проблему можно решить, воспроизведя правило генерации и просто суммируя диагонали в цикле. Однако есть способ получше. У нас есть 4 диагонали, начиная с середины матрицы, и для каждой диагонали мы можем найти последовательность:

$a_n = (9,25,49,81,121,...) = 4n^2 + 4n + 1$
$b_n = (5,17,37,65,101,...) = 4n^2 + 1$
$c_n = (3,13,31,57,91,...) = 4n^2 -2n + 1$
$d_n = (7,21,43,73,111,...) = 4n^2 + 2n + 1$

Теперь мы можем просуммировать эти диагональные последовательности плюс 1 для среднего элемента, чтобы получить решение в замкнутой форме:

$$s_n = 1 + \sum_{i=1}^{n}(a_i + b_i + c_i + d_i)
= 1 + \sum_{i=1}^{n}(16i^2 + 4i + 4) = 1 + 16\sum_{i=1}^{n}i^2 + 4\sum_{i=1}^{n}i + \sum_{i=1}^{n}4 = 1 + \frac{2}{3}*n(8n^2 + 15n + 13)$$
 
Остается вопрос, чему именно равен n. Поскольку мы разделили каждую диагональ на две части, образовав 4 квадранта, мы не можем пройти все 1001 элемента в любом направлении. Мы должны удалить средний элемент (и иметь нечетное размер квадрата) и разделить на два, поскольку нам нужна только половина диагонали. Для нашего примера:

$$ n = \frac{1001 - 1}{2}$$

И, поскольку многие вещи сокращаются, мы можем упростить и упаковать их вместе с помощью метода Горнера:

$$\frac{n (n(4n + 3) + 8) - 9)}{6}$$

Однако в таком случае много решений написать не получится, будем использовать также неоптимальные.

---

### Решение через рекурсию

```elixir
def sum_diagonals(n) when rem(n, 2) == 1 do
  sum_diagonals(n, 1)
end

defp sum_diagonals(1, sum), do: sum

defp sum_diagonals(n, sum) do
  layer = div(n - 1, 2)
  top_right = (2 * layer + 1) * (2 * layer + 1)
  top_left = top_right - 2 * layer
  bottom_left = top_left - 2 * layer
  bottom_right = bottom_left - 2 * layer

  sum_diagonals(n - 2, sum + top_right + top_left + bottom_left + bottom_right)
end
```

### Решение через хвостовую рекурсию

```elixir
def sum_diagonals(size) do
  sum_diagonals(size, 1, 0, 0)
end

defp sum_diagonals(1, _, sum, _), do: sum + 1

defp sum_diagonals(size, current, sum, step) do
  layer = div(size - 1, 2)

  new_sum =
    Stream.unfold((2 * layer + 1) * (2 * layer + 1), fn n -> {n, n - 2 * layer} end)
    |> Enum.take(4)
    |> Enum.sum()

  sum_diagonals(size - 2, current + 4 * step + 1, sum + new_sum, step + 2)
end
```

### Решение через модульность (reduce, filter, map)

```elixir
defmodule NumberSpiralDiagonals.SimpleModular do
  defmodule SequenceGenerator do
    def generate_sequence(n) when is_integer(n) and n > 1, do: 1..n
  end

  defmodule SequenceFilter do
    def filter_sequence(sequence), do: sequence |> Stream.filter(&(rem(&1, 2) == 1))
  end

  defmodule SequenceMapper do
    def map_sequence(sequence), do: sequence |> Stream.map(&diagonal_sum/1)

    defp diagonal_sum(1), do: 1
    defp diagonal_sum(size) do
      Stream.unfold(size * size, fn n -> {n, n - (size - 1)} end) |> Enum.take(4) |> Enum.sum()
    end
  end

  defmodule SequenceReducer do
    def reduce(sequence), do: sequence |> Enum.reduce(&(&1 + &2))
  end

  def sum_diagonals(1), do: 1
  def sum_diagonals(n) when is_integer(n) and n > 0 do
    SequenceGenerator.generate_sequence(n)
    |> SequenceFilter.filter_sequence()
    |> SequenceMapper.map_sequence()
    |> SequenceReducer.reduce()
  end
end

```

### Решение через бесконечные структуры и ленивые исполнения (Stream)

```elixir
def sum_diagonals(size) do
  Stream.iterate({size, 1, 0, 0}, fn {current_size, current, step, sum} ->
    layer = div(current_size - 1, 2)

    new_sum =
      Stream.unfold((2 * layer + 1) * (2 * layer + 1), fn n -> {n, n - 2 * layer} end)
      |> Enum.take(4)
      |> Enum.sum()

    {current_size - 2, current + 4 * step + 1, step + 2, sum + new_sum}
  end)
  |> Stream.take_while(fn {current_size, _, _, _} -> current_size >= 1 end)
  |> Enum.reduce(1, fn {_, _, _, sum}, acc -> acc + sum end)
end
```

### Решение через императивный язык (C)

```c
#include <stdio.h>
#include <assert.h>

int main() {
    int size = 1001;
    int sum = 1;
    int num = 1;
    int increment = 2;

    for (int i = 3; i <= size; i += 2) {
        for (int j = 0; j < 4; j++) {
            num += increment;
            sum += num;
        }
        increment += 2;
    }

    printf("The sum of the numbers on the diagonals is %d\n", sum);
    assert(sum == 669171001);

    return 0;
}
```

---

## Выводы

В ходе решения задач я применил некоторые приемы, присущие функциональным языкам:

  * Рекурсия - обычная и хвостовая - для реализации циклов
  * Pattern Matching (сопоставление с образцом) - для реализации ветвления, привязывания значений; паттерны и списки; guards у функций, etc.

Кроме того, добавил несколько решений, где из любопытства попробовал использовать асинхронные задачи, макросы, протоколы, OTP с GenServer и Supervisor. Глубоко оценил неподдерживаемость и незадокументированность большой части third-party библиотек Elixir'а. Много страдал с `espec`. Плакал.

Практика показала, что после ~3 часов мучений писать на ФПшном языке становится проще, но ощущение, что другие проблемы появятся на пути не проходит, но даже усиливается. Работа с коллекциями - классная (собственно, поэтому многие ООПшные языки переняли такие прикольные приёмы 3-10 лет назад). Подводя итог, могу сказать, что для одних задач писать решение на функциональном языке может быть удобнее по сравнению с традиционными императивными языками программирования, а для других - наоборот. Вывод: функциональные языки совсем не такие страшные, как о них принято говорить.
