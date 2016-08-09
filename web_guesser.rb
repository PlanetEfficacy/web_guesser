require 'sinatra'
require 'sinatra/reloader'
require './messages'
require 'pry'

class RandomNumberGenerator
  attr_accessor :guesses,
                :guess,
                :number,
                :background,
                :start,
                :restart

  def initialize
    @guess
    reset
  end

  def reset
    @number = rand(100)
    @guesses = 5
    @background = "#d9d9d9"
    @start = ""
    @restart = "none"
  end

  def subtract_guess
    @guesses = guesses - 1
  end

  def out_of_guesses?
    guesses == 0
  end

  def guess_is_number?
    ("0".."100").to_a.include?(guess)
  end

  def guess_feedback
    @guess = guess.to_i
    update_background
    return Message.way_too_high if way_too_high?
    return Message.too_high if too_high?
    return Message.way_too_low if way_too_low?
    return Message.too_low if too_low?
  end

  def update_background
    @background = "#e06666" if way_too_high? || way_too_low?
    @background = "#f4cccc" if (too_high? && !way_too_high?) || (too_low? && !way_too_low?)
  end

  def update_display
    @start = "none"
    @restart = ""
    @background = "#d9ead3" if win?
    @background = "#c9daf8" if lose?
  end

  def winner
    return "#{Message.win} #{Message.secret_number(number)}"
  end

  def loser
    return "#{Message.lose} #{Message.secret_number(number)}"
  end

  def run_end_game
    update_display
    message = win? ? winner : loser
  end

  def check_guess(guess)
    @guess = guess
    return Message.guess_requirement unless guess_is_number?
    subtract_guess
    return guess_feedback unless game_over?
    return run_end_game
  end

  private

  def too_high?
    guess.to_i > number
  end

  def way_too_high?
    guess.to_i > number + 5
  end

  def too_low?
    guess.to_i < number
  end

  def way_too_low?
    guess.to_i < number - 5
  end

  def win?
    guess.to_i == number
  end

  def lose?
    guesses <= 0 && guess.to_i != number
  end

  def game_over?
    win? || lose?
  end
end

game = RandomNumberGenerator.new

get '/' do
  cheat = params["cheat"] == "true" ? "" : "none"
  if params["guess"] && params["guess"] != ""
    guess = params["guess"]
    message = game.check_guess(guess)
  elsif params["play"] || params["guess"] == ""
    game.reset
    message = "Let's play! Pick a number 1 to 100."
  end
  background = game.background
  guesses_remaining = game.guesses
  erb :index, :locals => {:number => game.number,
                          :message => message,
                          :background => background,
                          :guesses_remaining => guesses_remaining,
                          :guess => guess,
                          :cheat => cheat,
                          :start => game.start,
                          :restart => game.restart}
end
