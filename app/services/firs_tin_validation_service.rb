# frozen_string_literal: true

class FirsTinValidationService < BaseValidationService
  def initialize(tin)
    super(tin, {
      type: :regex,
      pattern: /^\d{8}-\d{4}$/
    })
  end
end
