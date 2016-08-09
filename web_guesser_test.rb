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
    actual.overide(0)
    assert_equal "Way too high!", actual.check_guess("100")
  end

  def test_it_can_return_feedback_that_a_guess_is_too_low
    actual = RandomNumberGenerator.new(100)
    actual.overide(100)
    assert_equal "Way too low!", actual.check_guess("0")
  end

  def test_guesses_change_background
    actual = RandomNumberGenerator.new(100)
    assert_equal "#f4cccc", actual.close_guess
    assert_equal "#f4cccc", actual.background
    assert_equal "#e06666", actual.extreme_guess
    assert_equal "#e06666", actual.background
    assert_equal "#d9ead3", actual.successful_guess
    assert_equal "#d9ead3", actual.background
  end

  def test_it_starts_with_5_guesses
    actual = RandomNumberGenerator.new(100)
    assert_equal 5, actual.guesses
  end

  def test_it_can_subtract_guesses
    actual = RandomNumberGenerator.new(100)
    actual.subtract_guess
    assert_equal 4, actual.guesses
  end

  def test_it_knows_if_it_is_out_of_guesses
    actual = RandomNumberGenerator.new(100)
    5.times { actual.subtract_guess }
    assert_equal true, actual.out_of_guesses?
  end

  # def test_it_knows_when_the_game_is_over
  #   actual = RandomNumberGenerator.new(100)
  #   assert_equal false, actual.game_over?
  #   5.times { actual.subtract_guess }
  #   assert_equal true, actual.game_over?
  # end

  def test_it_knows_if_a_guess_is_invalid
    actual = RandomNumberGenerator.new(100)
    assert_equal false, actual.invalid_guess("a")
    assert_equal false, actual.invalid_guess("1000")
    assert_equal true, actual.invalid_guess("0")
    assert_equal true, actual.invalid_guess("50")
    assert_equal true, actual.invalid_guess("100")
  end



end
