defmodule PaymentsParserTest do
  use ExUnit.Case

  doctest PaymentsParser

  test "parser" do
    content = File.read!("test/fixtures/retorno.txt")
    ast = PaymentsParser.parse(content)
    assert Map.keys(ast) == [:contents, :header]
    assert Enum.count(ast[:contents]) == 8
  end
end
