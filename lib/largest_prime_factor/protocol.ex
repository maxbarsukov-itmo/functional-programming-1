defprotocol LargestPrimeFactor.Factorizable do
  @spec largest_prime_factor(number()) :: integer()
  def largest_prime_factor(n)
end

defimpl LargestPrimeFactor.Factorizable, for: Integer do
  def largest_prime_factor(n), do: LargestPrimeFactor.Optimized.largest_prime_factor(n)
end
