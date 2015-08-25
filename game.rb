#!/usr/bin/ruby

require_relative './cards'
require_relative './player'
require_relative './dealer'

# game.rb
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
    cards.shuffle!(number_of_decks * 2)

    self.cards = cards
  end

  def add_player(player)
    return 'game is not ready' if status != READY
    if players.length < max_players
      player.index = players.length
      players << player
      return 'added'
    else
      return "sorry max number of players is #{max_players}"
    end
  end

  def remove_player(player_i)
    if status == READY && !players[player_i].nil?
      player = players[player_i]

      players.delete_at(player_i)

      (player_i..(players.length - 1)).each do |p_i|
        players[p_i].index = p_i
      end

      player
    else
      false
    end
  end

  def player_betted
    betted = true

    players.each do |player|
      betted = false if player.bet == 0
    end

    betted
  end

  def deal
    card_added = true
    dealer.score = 0 # resets the dealer score
    (0..1).each do
      players.each do |player|
        card_added = player_deal_card(player) if card_added
      end

      card_added = dealer_deal_card if card_added
    end

    if card_added
      self.status = INPROGRESS
      self.player_i = 0
    end

    card_added
  end

  def hit
    return false unless status == INPROGRESS

    if player_i != -1
      card_added = player_hit(player_i)
      score = calc_score(players[player_i].cards)
    else
      card_added = dealer_hit
      score = calc_score(dealer.cards)
    end

    stand if score >= 21

    card_added
  end

  def stand
    return false unless status == INPROGRESS
    if player_i == -1
      self.status = OVER
      players_status if cacl_players_score
    elsif player_i < (players.length - 1)
      self.player_i += 1
    else
      self.player_i = -1
    end
  end

  def double_down
    return false unless status == INPROGRESS && player_i != -1
    bet = players[player_i].bet

    return false unless players[player_i].money >= bet && hit
    players[player_i].bet = bet * 2
    players[player_i].money -= bet

    stand
  end

  def calc_score(cards)
    num_aces = get_num_aces(cards)
    score = calc_score_with_aces(cards, num_aces)

    score
  end

  def cacl_players_score
    if status == OVER
      players.each_with_index do |player, i|
        player.score = calc_score(players[i].cards)
      end
      dealer.score = calc_score(dealer.cards)
      true
    else
      false
    end
  end

  def players_status
    players.each_with_index do |player, player_i|
      player_status(player, player_i)
    end
  end

  def to_s
    return_str = ''
    players.each do |player|
      return_str += player.to_s

      return_str += "\n"
    end

    return_str += dealer.to_s
    return_str
  end

  private

  def blackjack?(player_i)
    calc_score(players[player_i].cards) == 21
  end

  def player_blackjack(player)
    player.add_money(player.bet * 2.5)
    player.status = 'blackjack'
    player.bet = 0
  end

  def player_wins(player)
    player.add_money(player.bet * 2)
    player.status = 'wins'
    player.bet = 0
  end

  def player_push(player)
    player.add_money(player.bet)
    player.status = 'push'
    player.bet = 0
  end

  def player_loses(player)
    player.status = 'loses'
    player.bet = 0
  end

  def player_deal_card(player)
    player.score = 0 # resets score
    return false if cards.number_of_cards <= 0
    card = cards.card

    player.add_card(card) if card && card.valid?
  end

  def player_hit(player_i)
    card = cards.card
    players[player_i].add_card(card) if card && card.valid?
  end

  def dealer_deal_card
    card = cards.card
    dealer.add_card(card) if card && card.valid?
  end

  def dealer_hit
    card = cards.card
    dealer.add_card(card) if card && card.valid?
  end

  def get_num_aces(cards)
    aces_count = 0
    cards.each do |card|
      aces_count += 1 if card.number == 0
    end
    aces_count
  end

  def calc_score_without_aces(cards)
    score = 0
    cards.each do |card|
      if [10, 11, 12].include?(card.number)
        score += 10
      elsif card.number != 0
        score += (card.number + 1)
      end
    end
    score
  end

  def calc_score_with_aces(cards, num_aces)
    score = calc_score_without_aces(cards)
    (0..num_aces - 1).each do |i|
      ace_sum = (num_aces - i) * 11 + num_aces * i
      if (ace_sum + score) <= 21
        score += ace_sum
      elsif num_aces - 1 == i
        score += num_aces
      end
    end
    score
  end

  def player_status(player, player_i)
    if player.score > 21
      player_loses(player)
    elsif blackjack?(player_i)
      player_blackjack(player)
    elsif dealer.score > 21
      player_wins(player)
    elsif player.score > dealer.score
      player_wins(player)
    elsif player.score == dealer.score
      player_push(player)
    else
      player_loses(player)
    end
  end
end
