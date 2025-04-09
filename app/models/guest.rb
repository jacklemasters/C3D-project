class Guest < ApplicationRecord
  belongs_to :event, counter_cache: true
  
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
