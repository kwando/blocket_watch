defmodule BlocketWatch.Parser do
  import Meeseeks.CSS
  def parse(body) do
  	document = Meeseeks.parse(body)


    title = Meeseeks.one(document, css("h1.h3.subject_medium")) |> Meeseeks.text

    description =  Meeseeks.one(document, css(".motor-car-description")) |> Meeseeks.text

    price = Meeseeks.one(document, css("#price_container")) |> Meeseeks.text |> parse_price

    {:ok, %BlocketWatch.Advertisment{
      price: price,
      title: title,
      description: description
    }}
  end

  defp parse_price(price) do
  	price
  		|> String.replace_suffix(":-", "")
  		|> String.replace(" ", "")
  		|> Integer.parse
  		|> elem(0)
  end
end
