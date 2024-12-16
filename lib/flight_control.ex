defmodule FlightControl do
  alias FlightControl.Grid.Square
  alias FlightControl.Helpers
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

  @doc """
  List topics

  ## Examples

      iex> FlightControl.list_topics()
      []

  """
  def list_topics() do
    GenServer.call(__MODULE__.Worker, :list_topics)
  end

  @doc """
  For each topic lat, lng is inside we will return as a list.
  """
  def return_topics(lat, lng) do
    {:ok, topics} = list_topics()

    topics 
    |> Enum.filter(fn topic -> 
      {lat1, lng1, lat2, lng2} = Helpers.string_to_lat_lngs(topic)
      Square.inside?(lat, lng, Square.new(lat1, lng1, lat2, lng2))
    end)
  end
end
