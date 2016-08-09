require 'minitest/autorun'
require 'minitest/pride'
require './web_guesser.rb'

class WebGuesserTest < Minitest::Test
  attr_reader :game

  def setup
    @game = RandomNumberGenerator.new
  end

  def test_it_starts_as_a_new_game
    assert_equal Fixnum, game.number.class
    assert_equal 5, game.guesses
    assert_equal "#d9d9d9", game.background
  end

  def test_it_can_reset
    game.guesses = 2
    game.guess = "45"

    assert_equal 2, game.guesses

    game.reset

    assert_equal Fixnum, game.number.class
    assert_equal 5, game.guesses
    assert_equal "#d9d9d9", game.background
  end

  def test_guesses_can_be_set
    assert_equal 5, game.guesses
    game.guesses = 3
    assert_equal 3, game.guesses
  end

  def test_it_can_subtract_guesses
    game.subtract_guess
    assert_equal 4, game.guesses

    3.times { game.subtract_guess }
    assert_equal 1, game.guesses
  end

  def test_it_can_set_and_get_guess
    assert_equal nil, game.guess
    game.guess = 1
    assert_equal 1, game.guess
  end

  def test_it_knows_when_zero_guesses_remain
    game.guesses = 0
    assert_equal true, game.out_of_guesses?
  end

  def test_it_knows_if_guess_is_number
    game.guess = "a"
    assert_equal false, game.guess_is_number?
    game.guess = "10"
    assert_equal true, game.guess_is_number?
  end

  def test_it_messages_correctly_if_won
    game.number = 50
    expected = "You got it right! The SECRET NUMBER is 50"

    actual = game.winner

    assert_equal expected, actual
  end

  def test_it_messages_correctly_if_lose
    game.number = 50
    expected = "You got it wrong! The SECRET NUMBER is 50"

    actual = game.loser

    assert_equal expected, actual
  end

  def test_it_updates_background_color
    game.number = 50

    game.guess = "10"
    game.update_background
    actual_1 = game.background
    game.guess = "51"
    game.update_background
    actual_2 = game.background

    assert_equal "#e06666", actual_1
    assert_equal "#f4cccc", actual_2
  end

  def test_it_updates_background_color_for_end_game
    game.number = 50

    game.guess = "50"
    game.update_display
    actual_3 = game.background
    game.guess = "49"
    game.guesses = 0
    game.update_display
    actual_4 = game.background

    assert_equal "#d9ead3", actual_3
    assert_equal "#c9daf8", actual_4
  end

  def test_it_checks_guesses
    game.number = 50

    game.guess = "10"
    actual_1 = game.guess_feedback
    game.guess = "49"
    actual_2 = game.guess_feedback
    game.guess = "51"
    actual_3 = game.guess_feedback
    game.guess = "60"
    actual_4 = game.guess_feedback

    assert_equal Message.way_too_low, actual_1
    assert_equal Message.too_low, actual_2
    assert_equal Message.too_high, actual_3
    assert_equal Message.way_too_high, actual_4
  end

  def test_it_ends_the_game
    game.number = 50
    game.guess = 50
    assert_equal game.winner, game.run_end_game
    assert_equal 5, game.guesses

    game.number = 50
    game.guess = 80
    assert_equal game.loser, game.run_end_game
    assert_equal 5, game.guesses
  end

  def test_it_checks_guesses
    game.number = 50
    assert_equal 5, game.guesses

    game.check_guess("A")
    assert_equal 5, game.guesses

    game.check_guess("40")
    assert_equal 4, game.guesses

    game.check_guess("60")
    assert_equal 3, game.guesses

    game.check_guess("55")
    assert_equal 2, game.guesses

    game.check_guess("52")
    assert_equal 1, game.guesses
  end

  def test_it_checks_guesses_for_end_game
    game.number = 50
    # binding.pry
    actual = game.check_guess("50")
    assert_equal "You got it right! The SECRET NUMBER is 50", actual

    game.number = 50
    game.guesses = 0
    assert_equal 0, game.guesses
    actual =  game.check_guess("22")
    assert_equal "You got it wrong! The SECRET NUMBER is 50", actual

    game.reset
    assert_equal 5, game.guesses
  end
end
