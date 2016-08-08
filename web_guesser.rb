require 'sinatra'
require 'sinatra/reloader'


class RandomNumberGenerator

  attr_reader :random_number

  def initialize(number)
    @random_number = rand(number)
  end

  def message
    "The SECRET NUMBER is #{random_number}"
  end

end

number_generator = RandomNumberGenerator.new(100)

get '/' do
  number_generator.message
end
