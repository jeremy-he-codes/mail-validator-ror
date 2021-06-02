module Emails
  class LookupService < BaseService
    def initialize(emails)
      @emails = emails
    end

    def call
      @emails.each do |email|
        Rails.logger.info "Checking #{email} for validation"

        if Emails::ValidatorService.call(email)
          return email
        end
      end

      nil
    end
  end
end
