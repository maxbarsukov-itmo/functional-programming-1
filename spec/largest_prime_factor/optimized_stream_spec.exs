defmodule LargestPrimeFactor.OptimizedStreamSpec do
  @moduledoc "Testing realization that uses optimized solution with streams"

  use ESpec, async: true

  describe "optimized stream solution" do
    describe "largest_prime_factor/1" do
      it "returns the largest prime factor of 13195" do
        expect LargestPrimeFactor.OptimizedStream.largest_prime_factor(13_195) |> to(eq(29))
      end

      it "returns the largest prime factor of 600851475143" do
        expect LargestPrimeFactor.OptimizedStream.largest_prime_factor(600_851_475_143) |> to(eq(6857))
      end

      it "returns the number itself if it is prime" do
        expect LargestPrimeFactor.OptimizedStream.largest_prime_factor(29) |> to(eq(29))
      end

    end
  end
end
