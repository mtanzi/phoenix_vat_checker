defmodule VAT do
  defstruct valid: false,
            address: nil,
            country_code: nil,
            name: nil,
            request_date: nil,
            vat_number: nil

  def valid_format?(vat_number) do
    ExVatcheck.Countries.valid_format?(vat_number)
  end

  def fetch(vat_number) do
    ExVatcheck.check(vat_number)
    |> handle_vat
  end

  def handle_vat(%ExVatcheck.VAT{exists: false}) do
    {:error, 'Vat does not exist'}
  end

  def handle_vat(%ExVatcheck.VAT{valid: false}) do
    {:error, 'Vat not valid'}
  end

  def handle_vat(%ExVatcheck.VAT{
        exists: true,
        valid: true,
        vies_available: true,
        vies_response: vies_response
      }) do
    {:ok,
     %__MODULE__{
       address: "BC0 B1 D1 BROADCAST CENTRE\nWHITE CITY PLACE\n201 WOOD LANE\nLONDON\n\nW12 7TP",
       country_code: "GB",
       name: "BRITISH BROADCASTING CORPORATION",
       request_date: "2020-05-24",
       valid: true,
       vat_number: "333289454"
     }}
  end
end
