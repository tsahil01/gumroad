# frozen_string_literal: true

class OmanVatNumberValidationService < BaseValidationService
  def initialize(vat_number)
    super(vat_number, {
      type: :regex,
      pattern: /\AOM\d{10}\z/
    })
  end
end
