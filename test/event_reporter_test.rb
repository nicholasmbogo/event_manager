require 'pry'
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

  def test_can_find_all_Johns
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("first_name", "John")

    assert_equal 63, event.queue_count
  end

  def test_has_count_at_queue
    event = EventReporter.new

    assert_equal 0, event.queue_count
  end

  def test_is_empty_when_it_Is_clear
    event = EventReporter.new

    assert_equal [], event.queue_clear
  end

  def test_can_print_out_the_header
    skip
    event = EventReporter.new
    event.loader("full_event_attendees.csv")
    event.find("first_name", "John")

    assert_equal  63, event.queue_count
  end

  def test_is_empty_when_it_Is_clear
    event = EventReporter.new

    assert_equal [], event.queue_clear
  end

  def test_can_build_header_string
    event = EventReporter.new

    assert_equal "FIRST\tNAME\tLAST\tNAME\tEMAIL\tPHONE\tSTREET\tCITY\tSTATE\tZIPCODE", event.header_string
  end

  def test_it_can_build_a_key_data_string
    event = EventReporter.new
    event.queue = [Attendee.new({
      _: "1",
      regdate: "1,11/12/08 10:47",
      first_name: "Allison",
      last_name: "Nguyen",
      email_address: "arannon@jumpstartlab.com",
      homephone: "6154385000",
      street: "3155 19th St NW",
      city: "Washington",
      state: "DC",
      zipcode: "20010"
    })]
    result = event.queue_data_string
    assert_equal "Allison\tNguyen\tarannon@jumpstartlab.com\t6154385000\t3155 19th St NW\tWashington\tDC\t20010", result
  end

  def test_it_can_build_a_key_data_string_a_sorted_by_attribute
    event = EventReporter.new
    event.queue = [Attendee.new({
      _: "1",
      regdate: "1,11/12/08 10:47",
      first_name: "Allison",
      last_name: "Nguyen",
      email_address: "arannon@jumpstartlab.com",
      homephone: "6154385000",
      street: "3155 19th St NW",
      city: "Washington",
      state: "DC",
      zipcode: "20010"
    }),Attendee.new({
      _: "1",
      regdate: "1,11/12/08 10:47",
      first_name: "first",
      last_name: "last",
      email_address: "arannon@jumpstartlab.com",
      homephone: "6154385000",
      street: "3155 19th St NW",
      city: "Washington",
      state: "DC",
      zipcode: "10010"
    })]
    result = event.queue_data_string("zipcode")
    assert_equal "first\tlast\tarannon@jumpstartlab.com\t6154385000\t3155 19th St NW\tWashington\tDC\t10010", result.split("\n").first
  end
end
