class Event < ApplicationRecord
  belongs_to :place
  has_many :guests, dependent: :destroy

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
