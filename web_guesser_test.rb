require 'minitest/autorun'
require 'minitest/pride'
require './web_guesser.rb'

class WebGuesserTest < Minitest::Test

  def test_it_can_return_random_number
    actual = RandomNumberGenerator.new(100)
    random_number = actual.number
    assert_equal true,  random_number >= 0 && random_number <= 100
  end

  def test_it_can_return_a_random_number_message
    actual = RandomNumberGenerator.new(100)
    length = actual.message.length
    assert_equal true, length == 24 || length == 22 || length == 23
  end

  def test_it_can_return_feedback_that_a_guess_is_too_high
    actual = RandomNumberGenerator.new(100)
    assert_equal "Way too high!", actual.feedback(1000)
  end

  def test_it_can_return_feedback_that_a_gues_is_too_low
    actual = RandomNumberGenerator.new(100)
    assert_equal "Way too low!", actual.feedback(-1)
  end

end
