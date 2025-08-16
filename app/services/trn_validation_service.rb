# frozen_string_literal: true

class TrnValidationService < BaseValidationService
  def initialize(trn)
    super(trn, {
      type: :length,
      length: 15
    })
  end
end
