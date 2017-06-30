defmodule BlocketWatch.PriceParser do
  @doc ~S"""
  Parses a formatted text price and returns an integer.

  ## Examples
    iex> BlocketWatch.PriceParser.parse("2000:-")
    2000

    iex> BlocketWatch.PriceParser.parse("20 000 :-")
    20_000

    iex> BlocketWatch.PriceParser.parse(20_000)
    20_000
  """
  def parse(price) when is_number(price), do: price
  def parse(price) do
    price
      |> String.replace_suffix(":-", "")
      |> String.replace(" ", "")
      |> Integer.parse
      |> elem(0)
  end
end
