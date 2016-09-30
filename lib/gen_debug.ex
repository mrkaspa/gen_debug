defmodule GenDebug do
  use ExUnit.CaseTemplate

  defmodule DSL do
    defmacro gdebug(servers, [do: body]) do
      quote do
        for s <- unquote(servers), do: :sys.log(s, true)
        unquote(body)
        for s <- unquote(servers), do: :sys.log(s, true)
      end
    end

    @spec state(GenServer.Name) :: any
    def state(pid) do
      :sys.get_state(pid)
    end

    @spec received?(GenServer.Name, atom, any) :: boolean
    def received?(pid, kind, msg) do
      count_received(pid, kind, msg) > 0
    end

    @spec count_received(GenServer.Name, atom, any) :: non_neg_integer
    def count_received(pid, kind, msg) do
      {:ok, messages} = :sys.log(pid, :get)
      messages
      |> Enum.filter(fn(log) ->
        case kind do
          :gen_call ->
            match?({{:in, {:"$gen_call", _, ^msg}}, _, _}, log)
          :gen_cast ->
            match?({{:in, {:"$gen_cast", ^msg}}, _, _}, log)
          _ ->
            match?({{^kind, ^msg}, _, _}, log)
        end
      end)
      |> Enum.count
    end
  end

  using do
    quote do
      import GenDebug.DSL
    end
  end
end
