# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'open-uri'
# require 'openssl'
# require 'json'

# url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2021-01-01&endtime=2021-12-31&minmagnitude=4.5"
# response = URI.open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
# earthquakes = JSON.parse(response)["features"]

# earthquakes.each do |earthquake|
#   properties = earthquake["properties"]
#   Earthquake.first_or_create!(
#     location: properties["place"],
#     magnitude: properties["mag"],
#     depth: earthquake["geometry"]["coordinates"][2],
#     occurred_at: Time.at(properties["time"] / 1000)
#   )
# end
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: "React", redirect_uri: "", scopes: "")
  Doorkeeper::Application.create!(name: "Test client", redirect_uri: "", scopes: "")
  Doorkeeper::Application.create!(name: "Web client", redirect_uri: "", scopes: "")

end
User.first_or_create(email: 'saminu3110c@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  role: User.roles[:admin])