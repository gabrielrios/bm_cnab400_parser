defmodule ParseBench do
  use Benchfella

  bench "parser" do
    content = File.read!("test/fixtures/retorno.txt")
    ast = PaymentsParser.parse(content)
  end
end
