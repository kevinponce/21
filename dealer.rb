#!/usr/bin/ruby

require_relative './object.rb'

class Dealer
  attr_accessor :cards, :score
 
  def initialize
    self.cards = []
    self.score = 0
  end

  def add_card(card)
    self.cards << card
  end

  def remove_cards
    cards = self.cards

    self.cards = []

    cards
  end
end
