# frozen_string_literal: true


class TaxIdValidationService < BaseValidationService
  def initialize(tax_id, country_code)
    super(tax_id, {
      type: :custom_api,
      cache_key: ->(identifier) { "tax_id_validation_#{identifier}_#{country_code}" },
      method: :valid_tax_id?
    })
    @country_code = country_code
  end

  private
    TAX_ID_PRO_ENDPOINT_TEMPLATE = Addressable::Template.new(
      "https://v3.api.taxid.pro/validate?country={country_code}&tin={tax_id}"
    )
    TAX_ID_PRO_HEADERS = {
      "Authorization" => "Bearer #{TAX_ID_PRO_API_KEY}"
    }

    def valid_tax_id?
      response = HTTParty.get(TAX_ID_PRO_ENDPOINT_TEMPLATE.expand(country_code: @country_code, tax_id: identifier).to_s, headers: TAX_ID_PRO_HEADERS, timeout: 5)
      response.code == 200 && response.parsed_response["is_valid"]
    end
end
