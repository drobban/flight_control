defmodule FlightControl do
  @moduledoc """
  Documentation for `FlightControl`.
  """

  @doc """
  Subscribe

  ## Examples

      iex> FlightControl.subscribe("51.23131,5.123231:52.231312321,4.312321213")
      :ok

  """
  def subscribe(topic) do
    GenServer.cast(__MODULE__.Worker, {:subscribe, topic})
  end



  @doc """
  Unsubscribe

  ## Examples

      iex> FlightControl.unsubscribe("51.23131,5.123231:52.231312321,4.312321213")
      :ok

  """
  def unsubscribe(topic) do
    GenServer.cast(__MODULE__.Worker, {:unsubscribe, topic})
  end

  def list_topics() do 
    GenServer.call(__MODULE__.Worker, :list_topics)
  end
end
