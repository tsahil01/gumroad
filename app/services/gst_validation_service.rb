# frozen_string_literal: true

class GstValidationService < BaseValidationService
  def initialize(gst_id)
    super(gst_id, {
      type: :custom_api,
      cache_key: ->(identifier) { "iras_validation_#{identifier}" },
      method: :valid_gst
    })
  end

  private

  def valid_gst
    headers = {
      "X-IBM-Client-Id" => IRAS_API_ID,
      "X-IBM-Client-Secret" => IRAS_API_SECRET,
      "accept" => "application/json",
      "content-type" => "application/json"
    }
    body = {
      clientID: IRAS_API_ID,
      regID: identifier
    }.to_json

    response = HTTParty.post(IRAS_ENDPOINT, body:, timeout: 5, headers:)

    response["returnCode"] == "10" && response["data"]["Status"] == "Registered"
  end
end
