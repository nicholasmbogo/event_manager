require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/event_reporter'

class EventReporterTest < Minitest::Test

  def test_event_manager_exists
    event = EventReporter.new

    assert_instance_of EventReporter, event
  end

  def test_can_load_a_default_file
    event = EventReporter.new
    event.loader

    assert_equal 5175, event.attendees.length
    assert_instance_of Attendee, event.attendees.first
  end

  def test_can_load_a_file
    event = EventReporter.new
    event.loader("full_event_attendees.csv")

    assert_equal 5175, event.attendees.length
    assert_instance_of Attendee, event.attendees.first
  end
end
