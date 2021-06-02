module Emails
  class GeneratorService < BaseService
    def initialize(contact)
      @contact = contact
    end

    def call
      [
        "#{f_name_part}.#{l_name_part}",
        f_name_part,
        "#{f_name_part}#{l_name_part}",
        "#{l_name_part}.#{f_name_part}",
        "#{f_name_part.first}.#{l_name_part}",
        "#{f_name_part.first}#{l_name_part.first}"
      ].map { |prefix| "#{prefix}@#{domain}" }
    end

    private

    def domain
      @domain ||= @contact.url.downcase
    end

    def f_name_part
      @f_name_part ||= @contact.first_name.downcase
    end

    def l_name_part
      @l_name_part ||= @contact.last_name.downcase
    end
  end
end
