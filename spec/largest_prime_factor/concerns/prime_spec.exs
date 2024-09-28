defmodule LargestPrimeFactor.Concerns.PrimeSpec do
  @moduledoc "Testing Prime checker concern"

  use LargestPrimeFactor.Concerns.Prime
  use ESpec, async: true

  describe "checking is number prime" do
    it "detects prime numbers" do
      expect prime?(2) |> to(be_true())
      expect prime?(3) |> to(be_true())
      expect prime?(5) |> to(be_true())
      expect prime?(11) |> to(be_true())
      expect prime?(11_159) |> to(be_true())
      expect prime?(99_018_119) |> to(be_true())
      expect prime?(99_016_915_337) |> to(be_true())
      expect prime?(123_142_416_451) |> to(be_true())
      expect prime?(999_999_995_017) |> to(be_true())
    end

    it "detects non-prime numbers" do
      expect prime?(1) |> to(be_false())
      expect prime?(4) |> to(be_false())
      expect prime?(51) |> to(be_false())
      expect prime?(999_999_995_018) |> to(be_false())
    end
  end
end
