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
  end

  def queue_count
    @queue.count
  end

  def queue_clear
    @queue.clear
  end
end
