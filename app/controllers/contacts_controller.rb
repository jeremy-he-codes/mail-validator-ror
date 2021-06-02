class ContactsController < ApplicationController
  before_action :set_contact!, only: :lookup
  before_action :set_emails, only: :index

  def index
    @emails = ValidEmail.all
  end

  def lookup
    email_pool = Emails::GeneratorService.call(@contact)

    unless @email = ValidEmail.where(email: email_pool).first
      valid_email = Emails::LookupService.call(email_pool)
      @email = ValidEmail.find_or_create_by(email: valid_email) if valid_email.present?
    end

    set_emails if @email.present?
  end

  private

  def set_emails
    @emails = ValidEmail.all
  end

  def set_contact!
    @contact = Contact.new(contact_params)

    unless @contact.valid?
      @errors = @contact.errors.full_messages

      render :form_error
    end
  end

  def contact_params
    params.require(:contact).permit(
      :first_name,
      :last_name,
      :url,
    )
  end
end
