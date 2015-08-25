#!/usr/bin/ruby

require_relative './card'

# cards.rb
class Cards
  attr_accessor :stack, :number_of_decks

  def initialize
    self.stack = []
    self.number_of_decks = 0
  end

  def fresh_cards(number_of_decks)
    self.number_of_decks = number_of_decks
    self.stack = []

    (0..(self.number_of_decks - 1)).each do
      (0..3).each do |suit_i|
        (0..12).each do |number_i|
          card = Card.new(suit_i, number_i)
          stack << card
        end
      end
    end
  end

  def card
    if stack.length > 0
      card = stack[0]
      stack.delete_at(0)

      return card
    else
      return false
    end
  end

  def add_card(card)
    stack << card
  end

  def add_cards(cards)
    stack << cards
    stack.flatten!
  end

  def number_of_cards
    stack.length
  end

  def shuffle!(times)
    (0..times).each do
      (0..(stack.length - 1)).each do |card_i|
        temp = stack[card_i]
        rand_i = rand(stack.length - 1)
        stack[card_i] = stack[rand_i]
        stack[rand_i] = temp
      end
    end
    stack
  end
end
