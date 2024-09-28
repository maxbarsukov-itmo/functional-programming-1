defmodule NumberSpiralDiagonals.AsyncTaskSpec do
  @moduledoc "Testing realization that uses async task"

  use ESpec, async: true

  describe "async solution" do
    describe "sum_diagonals/1" do
      it "returns the correct sum for a 5x5 spiral" do
        expect NumberSpiralDiagonals.AsyncTask.sum_diagonals(5) |> to(eq(101))
      end

      it "returns the correct sum for a 1001x1001 spiral" do
        expect NumberSpiralDiagonals.AsyncTask.sum_diagonals(1001) |> to(eq(669_171_001))
      end

      it "returns 1 for a 1x1 spiral" do
        expect NumberSpiralDiagonals.AsyncTask.sum_diagonals(1) |> to(eq(1))
      end

      it "returns 25 for a 3x3 spiral" do
        expect NumberSpiralDiagonals.AsyncTask.sum_diagonals(3) |> to(eq(25))
      end
    end
  end
end
