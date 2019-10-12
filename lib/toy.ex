defmodule Toy do
  use GenServer

  def store(key, value) do
    GenServer.cast(__MODULE__, {:store, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def start_link, do: GenServer.start_link(__MODULE__, :ok, [name: Toy])

  def init(_args) do
    starting_state = %{
      key_value: %{}
    }

    {:ok, starting_state}
  end

  def handle_cast({:store, key, value}, state) do
    key_value = state.key_value

    new_key_value = Map.put(key_value, key, value)

    new_state = Map.put(state, :key_value, new_key_value)

    {:noreply, new_state}
  end

  def handle_call({:get, key}, _from, state) do
    key_value = state.key_value

    value = Map.get(key_value, key)
    {:reply, value, state}
  end
end
