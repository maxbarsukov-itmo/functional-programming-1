defmodule LargestPrimeFactor.SimpleModularSpec do
  @moduledoc "Testing realization that uses modules (generate, filter, reduce + map)"

  use ESpec, async: true

  describe "modular solution" do
    describe "largest_prime_factor/1" do
      it "returns the largest prime factor of 13195" do
        expect LargestPrimeFactor.SimpleModular.largest_prime_factor(13_195) |> to(eq(29))
      end

      it "returns the number itself if it is prime" do
        expect LargestPrimeFactor.SimpleModular.largest_prime_factor(29) |> to(eq(29))
      end

      it "handles smaller numbers correctly" do
        expect LargestPrimeFactor.SimpleModular.largest_prime_factor(2) |> to(eq(2))
        expect LargestPrimeFactor.SimpleModular.largest_prime_factor(3) |> to(eq(3))
        expect LargestPrimeFactor.SimpleModular.largest_prime_factor(5) |> to(eq(5))
      end
    end
  end
end
