# GenDebug

It's a library to debug and test GenServers

## Installation

The package can be installed as:

  ```elixir
  def deps do
    [{:gen_debug, "~> 0.1.0"}]
  end
  ```

## Usage

You can assert for a received message like this:

  ```elixir
  # here  goes the pids of the process to debug
  gdebug [pid] do
    # if received the message :demo via cast
    GenServer.cast(pid, :demo)
    assert received?(pid, :gen_cast, :demo)

    # if received the message :demo via call
    GenServer.call(pid, :demo)
    assert received?(pid, :gen_call, :demo)

    GenServer.call(pid, {:demo, :ok, :end})
    assert received?(pid, :gen_call, {:demo, :ok, :end})

    send pid, :demo
    assert received?(pid, :in, :demo)

    # if the message was not received
    refute received?(pid, :in, :not)
  end
  ```
