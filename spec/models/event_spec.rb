require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it 'requires a name' do
      event = Event.new(starts_at: Time.current, ends_at: Time.current + 1.hour)
      expect(event).not_to be_valid
      expect(event.errors[:name]).to include("can't be blank")
    end

    it 'requires a start time' do
      event = Event.new(name: "Test Event", ends_at: Time.current + 1.hour)
      expect(event).not_to be_valid
      expect(event.errors[:starts_at]).to include("can't be blank")
    end

    it 'requires an end time' do
      event = Event.new(name: "Test Event", starts_at: Time.current)
      expect(event).not_to be_valid
      expect(event.errors[:ends_at]).to include("can't be blank")
    end
  end
end
