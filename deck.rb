#!/usr/bin/ruby

require_relative "./card"

class Cards
  attr_accessor :stack, :number_of_decks

  def initialize()
    self.stack = []
    self.number_of_decks = 0
  end

  def fresh_deck(number_of_decks)
    self.number_of_decks = number_of_decks

    for deck_i in (0..(self.number_of_decks-1))
      for suit_i in (0..3)
        for number_i in (0..12)
          self.stack << Card.new(suit_i,number_i)          
        end
      end
    end
  end 

  def get_card
    if self.stack.length > 0
      card = self.stack[0]
      self.stack.delete_at(0)

      return card
    else
      return false
    end
  end

  def add_card(card)
    self.stack << card
  end

  def add_cards(cards)
    self.stack << cards
    self.stack.flatten!
  end

  def get_number_of_cards
    self.stack.length
  end

  def shuffle!(times)
    for i in 0..times
      for i in 0..self.stack.length
        r = rand(self.stack.length-i)+i
        self.stack[r], self.stack[i] = self.stack[i], self.stack[r]
      end
    end
    self.stack
  end
end
