class Event < ApplicationRecord
  # Relations
  belongs_to :place
  has_many :guests, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
