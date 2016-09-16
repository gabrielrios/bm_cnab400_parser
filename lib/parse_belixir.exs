defmodule ParseBelixir do
  use Belixir

  Belixir.ips "Parser" do
    content = File.read!("test/fixtures/retorno.txt")
    PaymentsParser.parse(content)
  end

  Belixir.compare(1) # Runs each benchmark for 3 seconds. If you don't send any parameter, it runs for 5 seconds.

end
