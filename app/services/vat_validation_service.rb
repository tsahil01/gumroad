# frozen_string_literal: true

require "valvat"

class VatValidationService < BaseValidationService
  def initialize(vat_id)
    super(vat_id, {
      type: :custom_logic,
      method: :validate_vat
    })
    @valvat = Valvat.new(vat_id)
  end

  private

  def validate_vat
    # If UK, just validate VAT id, no lookup exists for it.
    if @valvat.vat_country_code.to_s.upcase == "GB"
      @valvat.valid?
    else
      # First attempt lookup via the VIES service.
      vat_exists = @valvat.exists?(requester: GUMROAD_VAT_REGISTRATION_NUMBER) rescue nil

      if vat_exists.nil?
        # If VIES is down, Valvat#exists? might return nil, fallback to validation instead
        # # Note that this fallback creates issue described in https://www.notion.so/gumroad/Handle-subsequent-VAT-validation-leading-to-VAT-id-be-deemed-as-invalid-2a18232e2dea427086682ac2de161676
        # Basically the VAT "might not" be valid according to VIES but might pass Valvat checks,
        # and subsequently on subscription charges of future be tagged as invalid leading to VAT charge on the purchase.
        @valvat.valid?
      else
        vat_exists.present?
      end
    end
  end
end
