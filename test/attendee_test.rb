require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/attendee'

class AttendeeTest < Minitest::Test
  def test_has_data
    attendee = Attendee.new(
    {
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
    })
  end

  def test_attendee_exist
    attendee = Attendee.new(
    {
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
    })

    assert_instance_of Attendee, attendee
  end

  def test_can_clean_attributes
    data = {
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
    }
    attendee = Attendee.new(data)

    assert_equal data[:_], attendee.id
    assert_equal data[:regdate], attendee.regdate
    assert_equal data[:first_name], attendee.first_name
    assert_equal data[:last_name], attendee.last_name
    assert_equal data[:homephone], attendee.homephone
    assert_equal data[:email_address], attendee.email_address
    assert_equal data[:street], attendee.street
    assert_equal data[:city], attendee.city
    assert_equal data[:state], attendee.state
    assert_equal data[:zipcode], attendee.zipcode
  end
end
