require 'brcobranca'
file = "test/fixtures/retorno.txt"
Brcobranca::Retorno::Cnab400::Bradesco.load_lines(file)
