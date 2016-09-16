Benchee.run(%{time: 3}, %{
  "parser" => fn ->
    content = File.read!("test/fixtures/retorno.txt")
    PaymentsParser.parse(content)
  end
})
