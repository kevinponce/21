#!/usr/bin/ruby

require_relative './object.rb'

# dealer.rb
class Dealer
  attr_accessor :cards, :score, :status

  def initialize
    self.cards = []
    self.score = 0
    self.status = ''
  end

  def add_card(card)
    cards << card
  end

  def remove_cards
    cards = self.cards
    self.cards = []

    cards
  end

  def to_s
    cards = ''
    self.cards.each_with_index do |card, index|
      cards += card.to_s
      cards += ', ' if index != self.cards.length - 1
    end
    "Dealer has #{cards}#{(!status.empty? ? ' and ' + status : '')}"
  end
end
