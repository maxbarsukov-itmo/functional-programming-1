defmodule LargestPrimeFactor.GenServer do
  @moduledoc "Realization by using GenServer"

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def compute, do: GenServer.call(__MODULE__, :compute)

  ## Callbacks

  @impl true
  def init(n) do
    {:ok, n}
  end

  @impl true
  def handle_call(:compute, _from, n) do
    result = LargestPrimeFactor.Optimized.largest_prime_factor(n)
    {:reply, result, result - 2}
  end
end

defmodule LargestPrimeFactor.Application do
  @moduledoc "Supervisor for realization"

  use Application

  def start(_type, arg) do
    children = [
      {LargestPrimeFactor.GenServer, arg}
    ]

    opts = [strategy: :one_for_one, name: LargestPrimeFactor.GenServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
