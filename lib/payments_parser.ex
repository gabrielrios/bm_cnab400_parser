defmodule PaymentsParser do
  def parse(stream) do
    parse_header(stream)
  end

  defp parse_header(<< _header::bytes-size(26),
                    cnpj::bytes-size(20),
                    nome::bytes-size(30),
                    _bank_code::bytes-size(3),
                    _bank_name::bytes-size(15),
                    data::bytes-size(6),
                    _density::bytes-size(8),
                    id::bytes-size(5),
                    _empty::bytes-size(266),
                    _data_credito::bytes-size(6),
                    seq::bytes-size(6),
                    _blank::bytes-size(9),
                    contents::binary>>) do

    header = %{ cnpj: cnpj, name: nome, data: data, id: id, seq: seq }
    clear_line(contents, %{ header: header, contents: [] })
  end

  defp clear_line(<< "\r", contents::binary >>, data), do: clear_line(contents, data)
  defp clear_line(<< "\n", contents::binary >>, data), do: clear_line(contents, data)
  defp clear_line(<< contents::binary >>, data), do: parse_contents(contents, data)

  defp parse_contents(<< "1",
      _type_company::bytes-size(2),
      _cnpj::bytes-size(14),
      _zeros::bytes-size(3),
      contract::bytes-size(17),
      _control::bytes-size(25),
      _zeros1::bytes-size(8),
      id::bytes-size(12),
      _bank_use::bytes-size(22),
      _rateio::bytes-size(1),
      _zeros2::bytes-size(2),
      wallet::bytes-size(1),
      _occurency::bytes-size(2),
      _ocurrency_date::bytes-size(6),
      _document::bytes-size(10),
      _bank_id::bytes-size(20),
      expiry::bytes-size(6),
      _value::bytes-size(13),
      _bank::bytes-size(3),
      _agency::bytes-size(5),
      _currency::bytes-size(2),
      _::bytes-size(13),
      _::bytes-size(13),
      _juros::bytes-size(13),
      _iof::bytes-size(13),
      _abatimento::bytes-size(13),
      _desconto::bytes-size(13),
      value::bytes-size(13),
      _juros1::bytes-size(13),
      _others::bytes-size(13),
      _blank::bytes-size(2),
      _motivo::bytes-size(1),
      payment_date::bytes-size(6),
      _source::bytes-size(3),
      _blank1::bytes-size(10),
      _chk::bytes-size(4),
      _reject::bytes-size(10),
      _blank2::bytes-size(40),
      _::bytes-size(12),
      _blank3::bytes-size(14),
      seq::bytes-size(6),
      contents::binary>>, data) do

    payment = %{ value: value, payment_date: payment_date, expiry: expiry, seq: seq,
      wallet: wallet, id: id, contract: contract }

    data = %{ data | contents: [ payment | data[:contents]] }
    clear_line(contents, data)
  end

  defp parse_contents(<< "9", _::binary>>, data) do
    data
  end
end
