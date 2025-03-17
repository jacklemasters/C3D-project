require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'validations' do
    it 'requires a name' do
      event = Event.new(starts_at: Time.current, ends_at: Time.current + 1.hour)
      expect(event).not_to be_valid
      expect(event.errors[:name]).to include("can't be blank")
    end
  end
end
