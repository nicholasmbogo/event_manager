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
end
