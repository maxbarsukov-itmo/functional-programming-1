defmodule LargestPrimeFactor.ProtocolSpec do
  @moduledoc "Testing realization that uses protocols"

  use ESpec, async: true

  describe "optimized solution with protocol" do
    describe "largest_prime_factor/1" do
      it "returns the largest prime factor of 13195" do
        expect LargestPrimeFactor.Factorizable.largest_prime_factor(13_195) |> to(eq(29))
      end

      it "returns the largest prime factor of 600851475143" do
        expect LargestPrimeFactor.Factorizable.largest_prime_factor(600_851_475_143) |> to(eq(6857))
      end
    end
  end
end
