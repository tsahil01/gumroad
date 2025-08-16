# frozen_string_literal: true

class AbnValidationService < BaseValidationService
  def initialize(abn_id)
    super(abn_id, {
      type: :vatstack_api,
      vatstack_type: "au_gst"
    })
  end
end
