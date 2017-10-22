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

  def test_can_find_attendees_by_zipcode
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("zipcode", "50309")

    assert_equal "50309", event.queue.first.zipcode
  end

  def test_find_is_case_insensitive
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("first_name", "douglas")

    assert_equal "Douglas", event.queue.first.first_name
  end

  def test_find_can_eliminate_external_wide_space
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("first_name", " douglas ")

    assert_equal "Douglas", event.queue.first.first_name
  end

  def test_find_doesnot_eliminate_internal_wide_space
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("first_name", " Allisonsarah ")

    assert_equal [], event.queue
  end

  def test_find_doesnot_eliminate_internal_wide_space
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("last_name", " Zimmermanfake ")

    assert_equal [], event.queue
  end
end
