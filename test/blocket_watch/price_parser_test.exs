defmodule BlocketWatch.PriceParserTest do
  use ExUnit.Case, async: true
  alias BlocketWatch.PriceParser

  doctest PriceParser

  test "parse" do
    assert PriceParser.parse("2000") == 2000
    assert PriceParser.parse("2001 :-") == 2001
    assert PriceParser.parse("20 901:-") == 20_901
    assert PriceParser.parse("1 220 901:-") == 1_220_901

    assert PriceParser.parse(1_220_901) == 1_220_901
  end  
end
