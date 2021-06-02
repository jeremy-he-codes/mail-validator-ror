class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :first_name, :last_name, :url

  validates_presence_of :first_name, :last_name, :url
  validates_format_of :url, with: /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
