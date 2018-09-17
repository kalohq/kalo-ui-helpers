class User
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  EMAIL_REGEX = /.+@.+\..+/
  EMAIL_MESSAGE = "must be a valid email address"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: {with: EMAIL_REGEX, message: EMAIL_MESSAGE}
  validates :country_code, presence: true

  attr_accessor :first_name, :last_name, :email, :id, :phone_number, :address_line1, :address_line2, :city, :country_code, :state_province, :postal_code, :date_of_birth
  attr_reader :errors

  def initialize(attributes = {})
    @errors = ActiveModel::Errors.new(self)

    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def save
    self.validate
    # abort self.inspect
  end

  def persisted?
    false
  end
end
