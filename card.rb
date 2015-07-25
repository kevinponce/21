#!/usr/bin/ruby
class Card
  attr_accessor :suit, :number

  def initialize(suit,number)
    self.suit = suit unless (suit < 0 || suit > 3)
    self.number = number unless (number < 0 || number > 12)
  end

  def to_s
    suit = self.suit.to_i unless self.suit.nil?
    number = self.number.to_i unless self.number.nil?

    if !suit.nil? && !number.nil? && suit >= 0 && suit <= 3 && number >= 0 && number <= 12 
      suits = ['Spaids','Hearts','Clubs','Dimonds']
      numbers = ['Ace','2','3','4','5','6','7','8','9','10','Jack','Queen','King'] 

      "#{numbers[self.number]} of #{suits[self.suit]}"
    else
      "invalid card"
    end
  end

  def == otherCard
    self.number == otherCard.number
  end

  def != otherCard
    self.number != otherCard.number
  end
end
