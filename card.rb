#!/usr/bin/ruby

# card.rb
class Card
  attr_accessor :suit, :number

  def initialize(suit, number)
    self.suit = suit unless suit < 0 || suit > 3
    self.number = number unless number < 0 || number > 12
  end

  SUITS = %w(Spaids Hearts Clubs Dimonds)
  NUMBERS = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)

  def to_s
    suit = self.suit.to_i unless @suit.nil?
    number = self.number.to_i unless @number.nil?

    if valid?
      "#{NUMBERS[number]} of #{SUITS[suit]}"
    else
      'invalid card'
    end
  end

  def ==(other)
    number == other.number
  end

  def !=(other)
    number != other.number
  end

  def valid?
    valid_suit? && valid_number?
  end

  def valid_number?
    (number >= 0 && number <= 12) unless number.nil?
  end

  def valid_suit?
    (suit >= 0 && suit <= 3) unless suit.nil?
  end
end
