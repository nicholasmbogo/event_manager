require 'csv'
require 'pry'
puts "Event Manager Initialized"

contents = CSV.open 'full_event_attendees.csv', headers: true, header_converters: :symbol

puts contents.headers
binding.pry

doc = Nokogiri::HTML(f)
#   csv = CSV.open("/tmp/output.csv", 'w',{:col_sep => ",", :quote_char => '\'', :force_quotes => true})
#   #doc.xpath('//table/tbody/tr').take(10).each do |row|
#   doc.xpath('//table/tbody/tr').each do |row|
#     tarray = []
#     binding.pry
#     row.xpath('td').each do |cell|
#       tarray << cell.text
#     end
#     csv << tarray
#   end
# end
#
#   #csv.close
