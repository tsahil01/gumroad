# frozen_string_literal: true

class KraPinValidationService < BaseValidationService
  def initialize(kra_pin)
    super(kra_pin, {
      type: :regex,
      pattern: /\A[A-Z]\d{9}[A-Z]\z/
    })
  end
end
