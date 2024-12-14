defmodule FlightControl.Grid do
  defmodule Square do
    @type position :: float()

    @type t :: %__MODULE__{
            lat1: position(),
            lng1: position(),
            lat2: position(),
            lng2: position()
          }
    @enforce_keys [
      :lat1,
      :lng1,
      :lat2,
      :lng2
    ]
    defstruct [:lat1, :lng1, :lat2, :lng2]

    @doc """
    Create new grid square.

    ## Examples

      iex> FlightControl.Grid.Square.new(51.123, 9.123, 50.123, 10.123)
      %FlightControl.Grid.Square{lat1: 51.123, lng1: 9.123, lat2: 50.123, lng2: 10.123}
    """
    @spec new(position(), position(), position(), position()) ::
            t() | :error
    def new(lat1, lng1, lat2, lng2) do
      case {lat1 > lat2, lng1 < lng2} do
        {true, true} ->
          %__MODULE__{lat1: lat1, lng1: lng1, lat2: lat2, lng2: lng2}

        {_, _} ->
          # Invalid Square
          :error
      end
    end

    @doc """
    lat,lng Inside? square.

    ## Examples

      iex> square  = %FlightControl.Grid.Square{lat1: 51.123, lng1: 9.123, lat2: 50.123, lng2: 10.123}
      iex> FlightControl.Grid.Square.inside?(51.12, 9.1231, square)
      true
    """
    @spec inside?(position(), position(), %__MODULE__{}) ::
            true | false
    def inside?(lat, lng, %__MODULE__{} = square) do
      case {lat < square.lat1 && lat > square.lat2, lng > square.lng1 && lng < square.lng2} do
        {true, true} ->
          true

        {_, _} ->
          false
      end
    end
  end
end
