require 'pry'
require 'csv'
require './lib/attendee'
require './lib/cleaner'
require 'erb'

class EventReporter

  attr_reader :attendees
  attr_accessor :queue

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
      line[:homephone] = Cleaner.new.home_phone(line[:homephone])
      attendee = Attendee.new(line)
      @attendees << attendee
    end
  end

  def find(attribute, criteria)
    @attendees.each do |attendee|
      attendee_attribute = attendee.send(attribute)
      if attendee_attribute && attendee_attribute.upcase.strip == criteria.upcase.strip
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

  def header_string
    headers = [:first_name, :last_name, :email_address, :homephone, :street, :city, :state, :zipcode]

    headers.map do |header|
      result = header.to_s.upcase.gsub("_", " ") + ("\t")
      if result == "EMAIL ADDRESS\t"
        result = "EMAIL\t"
      elsif result == "HOMEPHONE\t"
        result = "PHONE\t"
      else
        result
      end
    end.join.rstrip
  end

  def queue_data_string(attribute = nil)
    if attribute
      sorted = @queue.sort do |a, b|
        a.send(attribute) <=> b.send(attribute)#sort the queue by comparing the attribute and send in the attribute
      end

    else
      sorted = @queue
    end
    queue_string = sorted.map do |attendee|
      "#{attendee.first_name}\t#{attendee.last_name}\t#{attendee.email_address}\t#{attendee.homephone}\t#{attendee.street}\t#{attendee.city}\t#{attendee.state}\t#{attendee.zipcode}"
    end.join("\n")
  end

  def print_queue(attribute = nil)
    puts header_string
    puts queue_data_string(attribute)
  end

  def save_queue(filename)
    CSV.open(filename, "w") do |csv|
      csv << header_string.split("\t")
      queue_data_string.split("\n").each do |attendee|
        csv << attendee.split("\t")
      end
    end
  end


  def queue_export_html(filename)
    #headers = [:first_name, :last_name, :homephone, :email_address, :street, :city, :state, :zipcode]
    #contents = CSV.open(csv, headers: true, header_converters: :symbol)
    template_letter = File.read("template.erb")
    erb_letter      = ERB.new(template_letter)
    form_letter = erb_letter.result(binding)
    #binding.pry
      Dir.mkdir("html") unless Dir.exists?("html")
      file = "html/#{filename}"


      File.open(file, "w") do |file|
        file.puts form_letter
      end
  end


end
event = EventReporter.new
event.loader
event.find("state", "DC")
event.save_queue("my_csv.csv")
