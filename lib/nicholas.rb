require 'csv'
require 'pry'
puts "Event Manager Initialized"

contents = CSV.open 'full_event_attendees.csv', headers: true, header_converters: :symbol

puts contents.headers
binding.pry
# contents.each do |row|
#   puts row[0]
# end
