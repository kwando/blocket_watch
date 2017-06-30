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
  def parse(price) when is_binary(price) do
    price
      |> String.replace_suffix(":-", "")
      |> String.replace(" ", "")
      |> Integer.parse
      |> elem(0)
  end
  def parse(price), do: {:error, "cannot parse #{inspect(price)} into a price"}

  def parse!(price) do
    case parse(price) do
      {:error, message} -> raise BlocketWatch.ParseError, message: message
      price -> price
    end
  end
end
