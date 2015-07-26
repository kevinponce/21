#!/usr/bin/ruby

require_relative "./cards"
require_relative "./player"
require_relative "./dealer"

class Game
  attr_accessor :players, :cards, :player_i, :status, :dealer, :max_players

  OVER = -1
  READY = 0
  INPROGRESS = 1

  def initialize
    self.players = []
    self.cards = nil
    self.player_i = -1
    self.status = READY
    self.dealer = Dealer.new
    self.max_players = 6
  end

  def get_decks(number_of_decks)
    cards = Cards.new
    cards.fresh_cards(number_of_decks)
    cards.shuffle!(number_of_decks*2)

    self.cards = cards
  end

  def add_player(player)
    if self.status == READY
      if self.players.length < self.max_players
        player.index = self.players.length
        self.players << player
        return "added"
      else
        return "sorry max number of players is #{self.max_players}"
      end
    else
      return "game is not ready"
    end
  end

  def remove_player(player_i)
    if self.status == READY && !self.players[player_i].nil?
      player = self.players[player_i]

      self.players.delete_at(player_i)

      for p_i in player_i..(self.players.length-1)
        self.players[p_i].index = p_i
      end

      player
    else
      false
    end
  end

  def player_betted
    betted = true    

    self.players.each do |player|
      if player.bet == 0
        betted = false
      end
    end

    betted
  end

  def deal
    valid = true
    self.dealer.score = 0 #resets the dealer score
    for i in 0..1 
      self.players.each do |player|
        player.score = 0 #resets score
        if valid && self.cards.get_number_of_cards > 0
          card = self.cards.get_card

          if card 
            player.add_card(card)
          else
            valid = false
          end
        else
          valid = false
         end
      end

      if valid && self.cards.get_number_of_cards > 0
        card = self.cards.get_card

        if card 
          self.dealer.add_card(card)
        else
          valid = false
        end
      else
        valid = false
      end
    end

    if valid
      self.status = INPROGRESS
      self.player_i = 0
    end

   valid
  end

  def hit
    if self.status == INPROGRESS
      valid = true
      if self.cards.get_number_of_cards > 0
        card = self.cards.get_card

        if card 
          if self.player_i != -1
            self.players[self.player_i].add_card(card)
          else
            self.dealer.add_card(card)
          end
        else 
          valid = false
        end
      else
        valid = false
      end
    else
      valid = false
    end

    score = calc_score(self.players[player_i].cards)

    if score >= 21
      stand
    end

    valid
  end

  def stand
    if self.status == INPROGRESS
      valid = true
      if self.player_i == -1
        self.status = OVER
        if cacl_players_score
          player_wins
        end
      elsif self.player_i < (self.players.length-1)
        self.player_i += 1
      else
        self.player_i = -1
      end
    else
      valid = false
    end
    
    valid
  end
  
  def double_down
    if self.status == INPROGRESS
      valid = true
      if self.player_i == -1
        valid = false
      else 
        bet = self.players[self.player_i].bet
        money = self.players[self.player_i].money
        if money >= bet
          hit

          self.players[self.player_i].bet = bet*2
          self.players[self.player_i].money = money-bet

          stand
        else
          valid = false
        end
      end
    else
      valid = false
    end
    
    valid
  end

  def calc_score(cards)
    score = 0
    num_aces = 0

    cards.each do |card|
      if [10,11,12].include?(card.number) 
        score += 10
      elsif card.number == 0
        num_aces += 1
      else
        score += (card.number+1)
      end
    end

    for i in (0..num_aces-1)
      ace_sum = (num_aces-i)*11+num_aces*i
      if (ace_sum+score) <= 21
        score += ace_sum
        i = num_aces
      elsif num_aces-1 == i
        score += (num_aces)
      end
    end    

    score
  end

  def cacl_players_score
    if self.status == OVER
      self.players.each_with_index do |player,i|
        player.score = calc_score(self.players[i].cards)
      end
      self.dealer.score = calc_score(self.dealer.cards)
      true
    else
      false
    end  
  end

  def player_wins
    self.players.each_with_index do |player,player_i|
      if player.score <= 21
        if blackjack?(player_i)
          player.add_money(player.bet*2.5)
          player.status = "blackjack"
        else
          if dealer.score <= 21
            if player.score >  dealer.score
              #player wins
              player.add_money(player.bet*2)
              player.status = "wins"
            elsif player.score == dealer.score
              #push
              player.add_money(player.bet)
              player.status = "push"
            else
              player.status = "loses"
            end
          else
            #player wins
            player.add_money(player.bet*2)
            player.status = "wins"
          end
        end
      else
        player.status = "loses"
      end
      player.bet = 0; 
    end
  end

  def blackjack?(player_i)
    if self.players[player_i].cards.length == 2
      if calc_score(self.players[player_i].cards) == 21
        self.players[player_i].status = 'blackjack'
        return true
      else
        return false
      end
    else
      return false
    end
  end


  def to_s
    return_str = ""
    self.players.each_with_index do |player,index|
      return_str += player.to_s

      return_str += "\n"
    end

    return_str += self.dealer.to_s
    return return_str
  end
end
