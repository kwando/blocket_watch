defmodule BlocketWatch.ParseError do
  defexception message: "invalid price"
end
defmodule BlocketWatch.Parser do
  def parse(body) do
    doc = Meeseeks.parse(body)

    try do
      title       = doc |> extract_text("h1.h3.subject_medium")
      description = doc |> extract_text(".motor-car-description")
      price       = doc |> extract_text("#price_container") |> BlocketWatch.PriceParser.parse!

      {:ok, %BlocketWatch.Advertisment{
        price: price,
        title: title,
        description: description
      }}
    rescue
      e in BlocketWatch.ParseError -> {:error, e.message}
    end
  end

  defp extract_text(doc, selector) when is_binary(selector) do
    import Meeseeks.CSS
    case Meeseeks.one(doc, css("#{selector}")) do
      nil -> {:error, "selector #{inspect selector} not found"}
      result -> Meeseeks.text(result)
    end
  end
end
