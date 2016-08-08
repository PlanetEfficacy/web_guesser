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

end

rng = RandomNumberGenerator.new(100)

get '/' do
  erb :index, :locals => {:number => rng.number }
end
