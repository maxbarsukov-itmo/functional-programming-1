defmodule LargestPrimeFactor.Concerns.Prime do
  @moduledoc "Concern for checking is number prime"

  defmacro __using__(_) do
    quote do
      def prime?(2), do: true

      def prime?(n) do
        Enum.all?(2..(:math.sqrt(n) |> ceil()), fn i -> rem(n, i) != 0 end)
      end
    end
  end
end
