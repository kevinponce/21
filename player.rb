#!/usr/bin/ruby

require_relative './object.rb'

class Player
  attr_accessor :cards, :money, :index, :bet, :score, :name, :status
 
  def initialize(money,name)
    self.money = (money.is_number? ? money : 0)
    self.cards = []
    self.index = nil
    self.bet = 0
    self.score = 0
    self.name = name
    self.status = ''
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

  def to_s
    cards = ""
    self.cards.each_with_index do |card,index| 
      cards += card.to_s
      if index != self.cards.length-1
        cards += ', '
      end
    end

    return "#{self.name} has #{cards}#{(!self.status.empty? ? ' and '+self.status : '')}"
  end
end
