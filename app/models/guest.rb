class Guest < ApplicationRecord
  # Relations
  belongs_to :event, counter_cache: true
  
  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
