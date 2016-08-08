require 'sinatra'
require 'sinatra/reloader'

class RandomNumberGenerator

  attr_reader :number

  def initialize(max)
    @number = rand(max)
  end

  def message
    "The SECRET NUMBER is #{number}"
  end

  def success
    "You got it right!\nThe SECRET NUMBER is #{number}"
  end

  def check_guess(guess)
    return "" unless guess
    guess = guess.to_i
    return "Way too high!" if guess > number + 5
    return "Way too low!" if guess < number - 5
    return "Too high!" if guess > number
    return "Too low!" if guess < number
    return success if guess == number
  end

end

rng = RandomNumberGenerator.new(100)

set :number, rng.number

get '/' do
  guess = params["guess"]
  message = rng.check_guess(guess)
  erb :index, :locals => {:number => settings.number, :message => message}
end
