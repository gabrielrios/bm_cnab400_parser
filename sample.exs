content = File.read!("test/fixtures/retorno.txt")
PaymentsParser.parse(content)
