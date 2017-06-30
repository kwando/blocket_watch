defmodule BlocketWatch.ParserTest do
  use ExUnit.Case, async: true

  test "parsing" do
    body   = File.read!("test/fixtures/example.html")
    {:ok, %BlocketWatch.Advertisment{} = ad} = BlocketWatch.Parser.parse(body)

    assert ad.price == 285000
    assert ad.title == "Audi TT COUPÉ 2.0 TFSI 211 HK Q ST -14"
    assert ad.description == "Mycket fin och trevligt utrustad Audi TT 2.0TFSI, 211hk med Quattro samt S-tronic, Vindruta med värmeisolerande glas, Automatiskt avbländande innerbackspegel, Blandad förbrukning 0.72 l/mil, Varmt välkomna till Toveks Bil i Lund"
    assert ad.url == nil
  end
end
