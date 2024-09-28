defmodule LargestPrimeFactor.PrimeMacro do
  @moduledoc "Macro for prime checking"

  defmacro is_prime_macro(n) do
    quote do
      (unquote(n) == 2 && true) ||
        Enum.all?(2..(:math.sqrt(unquote(n)) |> ceil()), fn i -> rem(unquote(n), i) != 0 end)
    end
  end
end

defmodule LargestPrimeFactor.WithMacro do
  @moduledoc "Naive realization with macro"

  import LargestPrimeFactor.PrimeMacro

  def largest_prime_factor(n) do
    if is_prime_macro(n) do
      n
    else
      2..ceil(:math.sqrt(n))
      |> Enum.filter(&(rem(n, &1) == 0 && is_prime_macro(&1)))
      |> Enum.max()
    end
  end
end

IO.puts(LargestPrimeFactor.WithMacro.largest_prime_factor(100))
