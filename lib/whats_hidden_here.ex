defmodule WhatsHiddenHere do
  @moduledoc """
  Functions in this module, will tell what's hidden behind the string.
  """

  @doc """
  This is "less erlangish" function.

  It will process the string that hasn't been encoded with any erlang specific
  funcions internally. This will make the function work closer to how it could
  be implemented in other programming languages.

  ## Examples

      iex> WhatsHiddenHere.less_erlangish_decode("UnZ6b2k=", 1)
      "Quynh"

  """
  def less_erlangish_decode(encoded_string, magic_number) do
    encoded_string
    |> Base.decode64!()
    |> String.to_charlist()
    |> Enum.map(&(&1 - magic_number))
    |> to_string()
  end

  @doc """
  This is "more erlangish" function.

  It consists of one more step, an invocation of an erlang function - the one,
  that is used to serialise terms before sending it over the network to other
  node in the cluster.

  ## Examples

      iex> WhatsHiddenHere.more_erlangish_decode("g2sABVJ2em9p", 1)
      "Quynh"

  """
  def more_erlangish_decode(encoded_string, magic_number) do
    encoded_string
    |> Base.decode64!()
    |> :erlang.binary_to_term()
    |> Enum.map(&(&1 - magic_number))
    |> to_string()
  end
end
