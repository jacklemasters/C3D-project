# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

place1 = Place.find_or_create_by!(name: "Test Place") do |place|
  place.attributes = {
    address: "123 Main St"
  }
end

place2 = Place.find_or_create_by!(name: "Another Place") do |place|
  place.attributes = {
    address: "456 Side St"
  }
end

Event.find_or_create_by!(name: "Test Event") do |event|
  event.attributes = {
    description: "Test Description",
    starts_at: Time.current.beginning_of_hour + 1.day,
    ends_at: Time.current.beginning_of_hour + 1.day + 1.hour,
    place: place1
  }
end

Event.find_or_create_by!(name: "Another Event") do |event|
  event.attributes = {
    description: "Another Description",
    starts_at: Time.current.beginning_of_hour + 2.days + 1.hour,
    ends_at: Time.current.beginning_of_hour + 2.days + 2.hours,
    place: place2
  }
end

Event.find_or_create_by!(name: "Earlier Event") do |event|
  event.attributes = {
    description: "This event has already happened",
    starts_at: Time.current.beginning_of_hour - 1.day,
    ends_at: Time.current.beginning_of_hour - 1.day + 1.hour,
    place: place1
  }
end

Event.find_or_create_by!(name: "Later Event") do |event|
  event.attributes = {
    description: "This event will happen later",
    starts_at: Time.current.beginning_of_hour + 1.day + 5.hour,
    ends_at: Time.current.beginning_of_hour + 1.day + 6.hours,
    place: place2
  }
end