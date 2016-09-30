defmodule GenDebugTest do
  use ExUnit.Case
  use GenDebug
  alias GenDebug.TestHelper.TestServer

  setup do
    {:ok, pid} = TestServer.start_link
    {:ok, pid: pid}
  end

  test "match the messages", %{pid: pid} do
    gdebug [pid] do
      GenServer.cast(pid, :demo)
      assert received?(pid, :gen_cast, :demo)

      GenServer.call(pid, :demo)
      assert received?(pid, :gen_call, :demo)

      GenServer.call(pid, {:demo, :ok, :end})
      assert received?(pid, :gen_call, {:demo, :ok, :end})

      send pid, :demo
      assert received?(pid, :in, :demo)
      
      refute received?(pid, :in, :not)
    end
  end

  test "gets the state", %{pid: pid} do
    assert state(pid) == [:ok]
  end
end
