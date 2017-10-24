require './lib/event_reporter'

class Runner

  def initialize(""full_event_attendees.csv"")
    @event_repo = EventReporter.new
  end


  def start_game
  end
end


    print "> "
    input = $stdin.gets.chomp
    puts input
