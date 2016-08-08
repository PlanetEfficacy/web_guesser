require 'minitest/autorun'
require 'minitest/pride'
require './web_guesser.rb'

class WebGuesserTest < Minitest::Test

  def test_it_can_return_random_number
    actual = RandomNumberGenerator.new(100)
    random_number = actual.random_number
    assert_equal true,  random_number >= 0 && random_number <= 100
  end

  def test_it_can_return_a_random_number_message
    actual = RandomNumberGenerator.new(100)
    length = actual.message.length
    assert_equal true, length == 24 || length == 22 || length == 23
  end
  
end
