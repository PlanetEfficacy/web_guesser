module Message
  def self.secret_number(number)
      "The SECRET NUMBER is #{number}"
  end

  def self.win
    "You got it right!"
  end

  def self.lose
    "You got it wrong!"
  end

  def self.too_high
    "Too high!"
  end

  def self.too_low
    "Too low!"
  end

  def self.way_too_high
    "Way too high!"
  end

  def self.way_too_low
    "Way too low!"
  end

  def self.guess_requirement
    "A guess must be a number."
  end
end
