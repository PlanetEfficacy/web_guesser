require 'sinatra'
require 'sinatra/reloader'

class RandomNumberGenerator

  attr_reader :number,
              :background

  def initialize(max)
    @number = rand(max)
    @background
  end

  def message
    "The SECRET NUMBER is #{number}"
  end

  def success
    "You got it right!\nThe SECRET NUMBER is #{number}"
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

  def check_guess(guess)
    return "" unless guess
    guess = guess.to_i
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
      successful_guess
      success
    end
  end
end

rng = RandomNumberGenerator.new(100)

set :number, rng.number

get '/' do
  guess = params["guess"]
  message = rng.check_guess(guess)
  background = rng.background
  erb :index, :locals => {:number => settings.number,
                          :message => message,
                          :background => background}
end
