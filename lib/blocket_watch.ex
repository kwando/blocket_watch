defmodule BlocketWatch do
  def get_url(url) do
    HTTPoison.get(url)
  end

  def get_advertisment(url) do
  	with {:ok, response} <- get_url(url),
  	{:ok, result} <- BlocketWatch.Parser.parse(response.body) do
  		{:ok, %{result | url: url}}
  	end
  end
end

defmodule BlocketWatch.Advertisment do
  defstruct [:url, :title, :description, :price]
end

defmodule BlocketWatch.Parser do
  def parse(body) do
  	import Meeseeks.CSS

  	document = Meeseeks.parse(body)

    import Meeseeks.CSS
    element = Meeseeks.one(document, css("h1.h3.subject_medium"))

    title = Meeseeks.text(element)

    description =  Meeseeks.one(document, css(".motor-car-description")) |> Meeseeks.text

    price = Meeseeks.one(document, css("#price_container")) |> Meeseeks.text |> parse_price

    {:ok, %BlocketWatch.Advertisment{price: price, title: title, description: description}}
  end

  defp parse_price(price) do
  	price
  		|> String.replace_suffix(":-", "")
  		|> String.replace(" ", "")
  		|> Integer.parse
  		|> elem(0)
  end
end
