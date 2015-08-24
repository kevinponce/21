#!/usr/bin/ruby

require_relative "./card"

class Cards
  attr_accessor :stack, :number_of_decks

  def initialize()
    self.stack = []
    self.number_of_decks = 0
  end

  def fresh_cards(number_of_decks)
    self.number_of_decks = number_of_decks
    self.stack = []

    (0..(self.number_of_decks-1)).each do |deck_i|
      (0..3).each do |suit_i|
        (0..12).each do |number_i|
          card = Card.new(suit_i,number_i)
          self.stack << card
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
    (0..times).each do |i|
      for card_i in 0..(self.stack.length - 1)
        temp = self.stack[card_i]
        rand_i = rand(self.stack.length - 1)
        self.stack[card_i] = self.stack[rand_i]
        self.stack[rand_i] = temp
      end
    end
    self.stack
  end
end
