defmodule FlightControl.Helpers do
  @doc """
  translate lat,lng strings to a tuple of floats.

  format: `lat1:lng1_lat2:lng2`
  """
  def string_to_lat_lngs(topic_string) do
    [ll1, ll2] = String.split(topic_string, "_")

    [lat1, lng1] = String.split(ll1, ":")
    [lat2, lng2] = String.split(ll2, ":")

    {
      String.to_float(lat1),
      String.to_float(lng1),
      String.to_float(lat2),
      String.to_float(lng2)
    }
  end
end
