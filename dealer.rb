#!/usr/bin/ruby

require_relative './object.rb'

class Dealer
  attr_accessor :cards, :score, :status
 
  def initialize
    self.cards = []
    self.score = 0
    self.status = ''
  end

  def add_card(card)
    self.cards << card
  end

  def remove_cards
    cards = self.cards

    self.cards = []

    cards
  end

  def to_s
    cards = ""
    self.cards.each_with_index do |card,index| 
      cards += card.to_s
      if index != self.cards.length-1
        cards += ', '
      end
    end
    return "Dealer has #{cards}#{(!self.status.empty? ? ' and '+self.status : '')}"
  end
end
