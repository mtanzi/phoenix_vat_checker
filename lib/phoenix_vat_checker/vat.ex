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
    {:error, 'VAT does not exist'}
  end

  def handle_vat(%ExVatcheck.VAT{valid: false}) do
    {:error, 'VAT not valid'}
  end

  def handle_vat(%ExVatcheck.VAT{
        exists: true,
        valid: true,
        vies_available: true,
        vies_response: vies_response
      }) do
    {:ok,
     %__MODULE__{
       address: vies_response.address,
       country_code: vies_response.country_code,
       name: vies_response.name,
       request_date: vies_response.request_date,
       valid: vies_response.valid,
       vat_number: vies_response.vat_number
     }}
  end
end
