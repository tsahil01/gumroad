# frozen_string_literal: true

class QstValidationService < BaseValidationService
  def initialize(qst_id)
    super(qst_id, {
      type: :custom_api,
      cache_key: ->(identifier) { "revenu_quebec_validation_#{identifier}" },
      method: :valid_qst?
    })
  end

  private
    QST_VALIDATION_ENDPOINT_TEMPLATE = Addressable::Template.new(
      "https://svcnab2b.revenuquebec.ca/2019/02/ValidationTVQ/{qst_id}"
    )

    def valid_qst?
      response = HTTParty.get(QST_VALIDATION_ENDPOINT_TEMPLATE.expand(qst_id: identifier).to_s, timeout: 5)
      response.code == 200 && response.parsed_response.dig("Resultat", "StatutSousDossierUsager") == "R"
    end
end
