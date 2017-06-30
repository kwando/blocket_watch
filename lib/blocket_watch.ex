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
