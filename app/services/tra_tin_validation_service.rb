# frozen_string_literal: true

class TraTinValidationService < BaseValidationService
  def initialize(tra_tin)
    super(tra_tin, {
      type: :regex,
      pattern: /\A\d{2}-\d{6}-[A-Z]\z/
    })
  end
end
