defmodule LargestPrimeFactor.AsyncTaskSpec do
  @moduledoc "Testing realization that uses async task"

  use ESpec, async: true

  describe "async task solution" do
    describe "largest_prime_factor/1" do
      it "returns the largest prime factor of 13195" do
        expect LargestPrimeFactor.AsyncTask.largest_prime_factor(13_195) |> to(eq(29))
      end

      it "returns the largest prime factor of 600851475143" do
        expect LargestPrimeFactor.AsyncTask.largest_prime_factor(600_851_475_143) |> to(eq(6857))
      end

      it "returns the number itself if it is prime" do
        expect LargestPrimeFactor.AsyncTask.largest_prime_factor(29) |> to(eq(29))
      end

      it "handles smaller numbers correctly" do
        expect LargestPrimeFactor.AsyncTask.largest_prime_factor(2) |> to(eq(2))
        expect LargestPrimeFactor.AsyncTask.largest_prime_factor(3) |> to(eq(3))
        expect LargestPrimeFactor.AsyncTask.largest_prime_factor(5) |> to(eq(5))
      end
    end

    describe "parallel largest_prime_factor/1 with Task.async_stream" do
      it "returns the largest prime factor in parallel for large number" do
        result = Task.async_stream(
          [600_851_475_143, 13_195],
          LargestPrimeFactor.AsyncTask,
          :largest_prime_factor,
          [],
          timeout: 10_000
        ) |> Enum.map(fn {:ok, value} -> value end)

        expect result |> to(eq([6857, 29]))
      end
    end
  end
end
