defmodule LargestPrimeFactor.SimpleRecSpec do
  @moduledoc "Testing realization that uses regular recursion"

  use ESpec, async: true

  describe "recursion solution" do
    describe "largest_prime_factor/1" do
      it "returns the largest prime factor of 13195" do
        expect LargestPrimeFactor.SimpleRec.largest_prime_factor(13_195) |> to(eq(29))
      end

      it "returns the largest prime factor of 600851475143" do
        expect LargestPrimeFactor.SimpleRec.largest_prime_factor(600_851_475_143) |> to(eq(6857))
      end

      it "returns the number itself if it is prime" do
        expect LargestPrimeFactor.SimpleRec.largest_prime_factor(29) |> to(eq(29))
      end

      it "handles smaller numbers correctly" do
        expect LargestPrimeFactor.SimpleRec.largest_prime_factor(2) |> to(eq(2))
        expect LargestPrimeFactor.SimpleRec.largest_prime_factor(3) |> to(eq(3))
        expect LargestPrimeFactor.SimpleRec.largest_prime_factor(5) |> to(eq(5))
      end
    end
  end
end
