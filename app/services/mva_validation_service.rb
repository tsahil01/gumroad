# frozen_string_literal: true

class MvaValidationService < BaseValidationService
  def initialize(mva_id)
    super(mva_id, {
      type: :vatstack_api,
      vatstack_type: "no_vat"
    })
  end
end
