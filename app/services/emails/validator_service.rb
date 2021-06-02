module Emails
  class ValidatorService < BaseService
    include HTTParty
    base_uri 'apilayer.net/api'

    CACHE_KEY = 'validate-email'

    def initialize(email)
      @email = email
    end

    def call
      is_valid = Rails.cache.fetch([CACHE_KEY, @email], expires_in: 1.day) do
        remote_validate
      end

      Rails.cache.delete([CACHE_KEY, @email]) if is_valid.nil?
      is_valid == true
    end

    private

    def remote_validate
      sleep 1 # API fails when requested several times in a second window
      Rails.logger.info "Requesting Email Check: #{@email}"

      response = self.class.get(
        '/check',
        query: {
          access_key: ENV['MAILBOXLAYER_ACCESS_KEY'],
          email: @email,
          smtp: 1,
          format: 1,
        },
      )

      if response.success?
        result = response.parsed_response.tap { |result| Rails.logger.info result }

        result["mx_found"] && result["smtp_check"] && result["format_valid"] && !result["catch_all"]
      else
        Rails.logger.error "Error while validating #{@email}: #{response.response}"
        nil
      end
    rescue => error
      Rails.logger.error "Error while accessing the API: #{error.inspect}"
      nil
    end
  end
end
