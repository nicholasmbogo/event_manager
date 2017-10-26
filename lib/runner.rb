require './lib/event_reporter'
require './lib/help'

class Runner

  attr_reader :event_repo

  def initialize
    @event_repo = EventReporter.new
    @help = Help.new
  end

  def start_game
    until @choice == "quit" do
       print "> "
       @choice = $stdin.gets.chomp

       if @choice == "help"
         puts "Available commands:\n<load <filename>>\n<find <attribute> <criteria>>\n<queue count>\n<queue clear>\n<queue print>\n<queue print by <attribute>>\n<queue save to <filename.csv>>\n<queue export html <filename.csv>>"
         
       elsif @choice == "help save to"
         puts @help.help_queue_save
       elsif @choice == "help queue count"
         puts @help.help_queue_count
       elsif @choice == "queue find"
         puts @help.help_find
       elsif @choice == "queue clear"
         puts @help.queue_clear
       elsif @choice == "queue print"
         puts @help.queue_print
       elsif @choice == "queue print by"
         puts @help.help_queue_print_by
       end

       split = @choice.split(" ")
      if split[0] == "load"
         file = split[1]
         if file
           event_repo.loader(file)
           puts "you loaded #{file}"
         else
           event_repo.loader
           puts "you loaded our default file"
         end


      elsif split[0] == "find"
        event_repo.find(split[1], split[2])

      elsif split[0] == "queue" && split[1] == "count"
        puts event_repo.queue_count

      elsif split[0] == "queue" && split[1] == "clear"
        puts event_repo.queue_clear

      elsif split[0] == "queue" && split[1] == "print"
        if split[2]
          event_repo.print_queue(split[3])
        end

      elsif split[0] == "queue" && split[1] == "export" && split[2] == "html" && split[3]
        if split[3]
          event_repo.queue_export_html(split[3])
        else
          event_repo.print_queue
        end
      end
    end
  end
end

runner = Runner.new
runner.start_game
