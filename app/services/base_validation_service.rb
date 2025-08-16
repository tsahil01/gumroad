# frozen_string_literal: true

class BaseValidationService
  attr_reader :identifier, :validation_config

  def initialize(identifier, validation_config)
    @identifier = identifier
    @validation_config = validation_config
  end

  def process
    return false if identifier.blank?

    case validation_config[:type]
    when :regex
      regex_validation
    when :length
      length_validation
    when :vatstack_api
      vatstack_api_validation
    when :custom_api
      custom_api_validation
    when :custom_logic
      send(validation_config[:method])
    else
      raise ArgumentError, "Unknown validation type: #{validation_config[:type]}"
    end
  end

  private

  def regex_validation
    identifier.match?(validation_config[:pattern])
  end

  def length_validation
    identifier.length == validation_config[:length]
  end

  def vatstack_api_validation
    response = Rails.cache.fetch("vatstack_validation_#{validation_config[:vatstack_type]}_#{identifier}", expires_in: 10.minutes) do
      url = "https://api.vatstack.com/v1/validations"
      headers = {
        "X-API-KEY" => VATSTACK_API_KEY
      }
      params = {
        type: validation_config[:vatstack_type],
        query: identifier
      }.stringify_keys

      HTTParty.post(url, body: params, timeout: 5, headers:)
    end

    return false if "INVALID_INPUT" == response["code"]
    return false if response["valid"].nil?

    response["valid"] && response["active"]
  end

  def custom_api_validation
    Rails.cache.fetch(validation_config[:cache_key].call(identifier), expires_in: 10.minutes) do
      send(validation_config[:method])
    end
  end
end
