defmodule BlocketWatchTest do
  use ExUnit.Case
  doctest BlocketWatch

  def parse_price(price) do
  	price
  		|> String.replace_suffix(":-", "")
  		|> String.replace(" ", "")
  		|> Integer.parse
  		|> elem(0)
  end

  test "fetching and parsing ad from blocket" do
  	url = "https://www.blocket.se/lund/Audi_TT_COUPE_2_0_TFSI_211_HK_Q_ST_73337466.htm"
  	{:ok, ad} = BlocketWatch.get_advertisment(url)

  	assert ad.price == 285000
  	assert ad.title == "Audi TT COUPÉ 2.0 TFSI 211 HK Q ST -14"
  	assert ad.description == "Mycket fin och trevligt utrustad Audi TT 2.0TFSI, 211hk med Quattro samt S-tronic, Vindruta med värmeisolerande glas, Automatiskt avbländande innerbackspegel, Blandad förbrukning 0.72 l/mil, Varmt välkomna till Toveks Bil i Lund"
  	assert ad.url == url
  end
end
