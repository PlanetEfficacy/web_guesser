require 'minitest/autorun'
require 'minitest/pride'
require './messages'

class MessageTest < Minitest::Test

  def test_it_has_a_secret_number_message
    length = Message.secret_number(10).chars.length
    assert_equal 23, length
  end

  def test_it_has_a_win_message
    assert_equal "You got it right!", Message.win
  end

  def test_it_has_a_lose_message
    assert_equal "You got it wrong!", Message.lose
  end

  def test_it_has_a_too_high_message
    assert_equal "Too high!", Message.too_high
  end

  def test_it_has_a_too_low_message
    assert_equal "Too low!", Message.too_low
  end

  def test_it_has_a_too_high_message
    assert_equal "Way too high!", Message.way_too_high
  end

  def test_it_has_a_too_low_message
    assert_equal "Way too low!", Message.way_too_low
  end

  def test_it_has_a_guess_requirements_message
    assert_equal "A guess must be a number.", Message.guess_requirement
  end

end
