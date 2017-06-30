defmodule BlocketWatch.Parser do
  def parse(body) do
    doc = Meeseeks.parse(body)

    title       = doc |> extract_text("h1.h3.subject_medium")
    description = doc |> extract_text(".motor-car-description")
    price       = doc |> extract_text("#price_container") |> BlocketWatch.PriceParser.parse

    {:ok, %BlocketWatch.Advertisment{
      price: price,
      title: title,
      description: description
    }}
  end

  defp extract_text(doc, selector) when is_binary(selector) do
    import Meeseeks.CSS
    Meeseeks.one(doc, css("#{selector}")) |> Meeseeks.text
  end
end
