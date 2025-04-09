class Place < ApplicationRecord
  # Relations
  has_many :events

  # Validations
  validates :name, presence: true
end
