require './lib/event_reporter'

class Runner

  attr_reader :event_repo

  def initialize
    @event_repo = EventReporter.new
  end

  def start_game
    while true
       print "> "
       choice = $stdin.gets.chomp
       split = choice.split(" ")
       if split[0] == "load"
         file = split[1]
         if file
           event_repo.loader(file)

         else
           event_repo.loader
         end
      elsif split[0] == "find"
        event_repo.find(split[1], split[2])

      elsif split[0] == "queue" && split[1] == "count"
        puts event_repo.queue_count

      elsif split[0] == "queue" && split[1] == "clear"
        event_repo.queue_clear

      elsif split[0] == "queue" && split[1] == "print"
        if split[2]
          event_repo.print_queue(split[3])

        else
          event_repo.print_queue
        end
      end
    end
  end
end
runner = Runner.new
runner.start_game
