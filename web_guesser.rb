require 'sinatra'
require 'sinatra/reloader'

class RandomNumberGenerator

  attr_reader :number,
              :background,
              :guesses

  def initialize(max)
    reset_game(max)
  end

  def overide(new_number)
    @number == new_number
  end

  def subtract_guess
    @guesses -= 1
    "Try again - #{guesses} remaining."
  end

  def out_of_guesses?
    @guesses == 0
  end

  def message
    "The SECRET NUMBER is #{number}"
  end

  def reset_game(max)
    @number = rand(max)
    @guesses = 5
    @background = "#d9d9d9"
  end

  def success
    old_number = number
    reset_game(100)
    "You got it right!\nThe SECRET NUMBER was #{old_number}"
  end

  def failure
    old_number = number
    reset_game(100)
    "You got it wrong!\nThe SECRET NUMBER was #{old_number}"
  end

  def extreme_guess
    @background = "#e06666"
  end

  def close_guess
    @background = "#f4cccc"
  end

  def successful_guess
    @background = "#d9ead3"
  end

  def invalid_guess(guess)
    ("0".."100").to_a.include?(guess)
  end

  def assess_guess(guess)
    if guess > number + 5
      extreme_guess
      "Way too high!"
    elsif guess > number
      close_guess
      "Too high!"
    elsif guess < number - 5
      extreme_guess
      "Way too low!"
    elsif guess < number
      close_guess
      "Too low!"
    else
      success
    end
  end

  def check_guess(guess)
    return "" unless invalid_guess(guess)
    return failure if out_of_guesses?
    subtract_guess
    assess_guess(guess.to_i)
  end
end

game = RandomNumberGenerator.new(100)

get '/' do

  guess = params["guess"]
  message = game.check_guess(guess)
  background = game.background
  guesses_remaining = game.guesses
  erb :index, :locals => {:number => game.number,
                          :message => message,
                          :background => background,
                          :guesses_remaining => guesses_remaining,
                          :guess => guess}
end
