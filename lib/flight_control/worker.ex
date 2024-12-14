defmodule FlightControl.Worker do
  require Logger
  use GenServer

  @table_name :radar_stations

  # Starts the GenServer and ETS table
  def start_link(_) do
    Logger.debug(inspect(__MODULE__))
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    table = :ets.new(@table_name, [:set, :protected, :named_table])
    {:ok, %{table: table}}
  end

  def handle_cast({:subscribe, topic}, state) do
    case :ets.lookup(state.table, topic) do
      [] ->
        :ets.insert(state.table, {topic, 1})

      [{_key, _value}] ->
        :ets.update_counter(state.table, topic, {2, 1})
    end

    {:noreply, state}
  end

  def handle_cast({:unsubscribe, topic}, state) do
    case :ets.lookup(state.table, topic) do
      [] ->
        nil

      [{_key, _value}] ->
        new_count = :ets.update_counter(state.table, topic, {2, -1})

        if new_count <= 0 do
          :ets.delete(state.table, topic)
        end
    end

    {:noreply, state}
  end

  def handle_call(:list_topics, _from, state) do
    topics = :ets.tab2list(state.table) |> Enum.map(fn {topic, _counter} -> topic end)
    {:reply, {:ok, topics}, state}
  end
end
