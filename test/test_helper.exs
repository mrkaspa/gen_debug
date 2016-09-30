ExUnit.start()

defmodule GenDebug.TestHelper do
  defmodule TestServer do
    use GenServer

    def start_link do
      GenServer.start_link(__MODULE__, [:ok])
    end

    def handle_cast(:demo, state) do
      {:noreply, state}
    end

    def handle_call(:demo, _from, state) do
      {:reply, state, state}
    end

    def handle_call(_msg, _from, state) do
      {:reply, state, state}
    end
  end
end
