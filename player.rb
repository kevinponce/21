#!/usr/bin/ruby

require_relative './object.rb'

class Player
  attr_accessor :cards, :money, :index, :bet, :score
 
  def initialize(money)
    self.money = (money.is_number? ? money : 0)
    self.cards = []
    self.index = nil
    self.bet = 0
    self.score = 0
  end

  def add_money(money) 
    self.money += money unless !money.is_number?
  end

  def place_bet(money)
    if money.is_number? && (self.money - money) >= 0
      self.money -= money
      self.bet += money

      true
    else
      false
    end
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
