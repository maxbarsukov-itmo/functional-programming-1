defmodule LargestPrimeFactor.GenServerSpec do
  @moduledoc "Testing realization that uses gen server + supervisor"

  use ESpec, async: true

  describe "optimized with genserver solution" do
    describe "supervised process for largest_prime_factor" do
      it "restarts the process in case of failure" do
        LargestPrimeFactor.Application.start([], 600_851_475_143)
        expect LargestPrimeFactor.GenServer.compute |> to(eq(6857))
        expect LargestPrimeFactor.GenServer.compute |> to(eq(457))
      end
    end
  end
end
