#!/usr/bin/ruby

require_relative './object.rb'

# player.rb
class Player
  attr_accessor :cards, :money, :index, :bet, :score, :name, :status

  def initialize(money, name)
    self.money = (money.number? ? money : 0)
    self.cards = []
    self.index = nil
    self.bet = 0
    self.score = 0
    self.name = name
    self.status = ''
  end

  def add_money(money)
    self.money += money if money.number?
  end

  def place_bet(money)
    if money.number? && (self.money - money) >= 0
      self.money -= money
      self.bet += money

      true
    else
      false
    end
  end

  def add_card(card)
    num_cards = cards.length
    cards << card if card.class.name.to_s == 'Card' && card.valid?
    num_cards != cards.length
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

    "#{name} has #{cards}#{(!status.empty? ? ' and ' + status : '')}"
  end
end
