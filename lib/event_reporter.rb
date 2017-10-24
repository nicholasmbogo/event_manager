require 'pry'
require 'csv'
require './lib/attendee'
require './lib/cleaner'
class EventReporter

  attr_reader :attendees, :queue

  def initialize
    @attendees = []
    @queue = []
  end

  def loader(file = "full_event_attendees.csv")
    @attendees = []
    contents = CSV.open(file, headers: true, header_converters: :symbol)
    #binding.pry
    contents.each do |line|
      line[:_] = line[0]
      line[:zipcode] = Cleaner.new.clean_zipcode(line[:zipcode])
      attendee = Attendee.new(line)
      @attendees << attendee
    end
  end

  def find(attribute, criteria)
    @attendees.each do |attendee|
      if attendee.send(attribute).upcase.strip == criteria.upcase.strip
        @queue << attendee
      end
    end
    return @queue
  end

  def queue_count
    @queue.count
  end

  def queue_clear
    @queue.clear
  end

  def queue_print
    headers = [:first_name, :last_name, :email_address, :homephone, :street, :city, :state, :zipcode]

    #contents.headers[2..9]
    headers.map do |header|
      result = header.to_s.upcase.gsub("_", " ") + (" ") #refactor
      #binding.pry
      if result == "EMAIL ADDRESS "
        result = "EMAIL "
      elsif result == "HOMEPHONE "
        result = "PHONE "
      else
        result
      end
    end.join#(" ")
  end
end
