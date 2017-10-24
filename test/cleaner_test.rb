require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cleaner'

class CleanerTest < Minitest::Test
  def test_cleaner_exists
    cleaner = Cleaner.new

    assert_instance_of Cleaner, cleaner
  end

  def test_can_clean_zipcode
    cleaner = Cleaner.new

    assert_equal "00000", cleaner.clean_zipcode(nil)
    assert_equal "04352", cleaner.clean_zipcode("4352")
    assert_equal "63452", cleaner.clean_zipcode("634523")
    assert_equal "80012", cleaner.clean_zipcode("80012")
  end

  def test_can_clean_phone_numbers_with_dots
    unclean = "615.438.5000"
    cleaner = Cleaner.new

    assert_equal "(615) 438-5000", cleaner.home_phone(unclean)
  end

  def test_can_clean_an_empty_number
    unclean = nil
    cleaner = Cleaner.new

    assert_equal "", cleaner.home_phone(unclean)
  end

  def test_can_clean_a_phone_with_lines
    unclean = "615-438-5000"
    cleaner = Cleaner.new

    assert_equal "(615) 438-5000", cleaner.home_phone(unclean)
  end

  def test_can_clean_a_phone_number_without_space
    unclean = "5126732000"
    cleaner = Cleaner.new

    assert_equal "(512) 673-2000", cleaner.home_phone(unclean)
  end
end
