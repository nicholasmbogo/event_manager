require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/help'

class HelpTest < Minitest::Test
  def test_help_exists
    help = Help.new

    assert_instance_of Help, help
  end
end
