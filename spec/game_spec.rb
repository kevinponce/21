#!/usr/bin/ruby

require_relative './spec_helper'
require_relative '../game'
require_relative '../player'
require_relative '../card'

describe 'game' do
  describe 'init' do
    it 'has 0 players' do
      game = Game.new

      expect(game.players).to be_empty
    end

    it 'does not have 3 players' do
      game = Game.new

      expect(game.players).to be_empty
    end

    it 'has 0 players' do
      game = Game.new

      expect(game.players.length).to eq(0)
    end

    it 'does not have 3 players' do
      game = Game.new

      expect(game.players.length).to_not eq(3)
    end

    it 'deck is nil' do
      game = Game.new
      expect(game.cards).to be_nil
    end

    it 'dealers turn' do
      game = Game.new
      expect(game.player_i).to eq(-1)
    end

    it 'not player 1 turn'do
      game = Game.new
      expect(game.player_i).to_not eq(0)
    end

    it 'status is Ready'do
      game = Game.new
      expect(game.status).to eq(Game::READY)
    end

    it 'status is not INPROGRESS' do
      game = Game.new
      expect(game.status).to_not eq(Game::INPROGRESS)
    end

    it 'stutus is not OVER' do
      game = Game.new
      expect(game.status).to_not eq(Game::OVER)
    end
  end

  describe 'get decks' do
    it 'is not empty' do
      game = Game.new
      game.get_decks(3)

      expect(game.cards.stack).to_not be_empty
    end

    it 'there is 3' do
      game = Game.new
      game.get_decks(3)

      expect(game.cards.number_of_decks).to eq(3)
    end

    it 'there is not 4' do
      game = Game.new
      game.get_decks(3)

      expect(game.cards.number_of_decks).to_not eq(4)
    end
  end

  describe 'add players' do
    before :each do
      @game = Game.new
      @player = Player.new(50, 'Test name')
      @game.status = Game::READY
    end

    it 'count 1' do
      @game.add_player(@player)

      expect(@game.players.length).to eq(1)
    end

    it 'count not 0' do
      @game.add_player(@player)

      expect(@game.players.length).to_not eq(0)
    end

    it 'count 1' do
      @game.add_player(@player)

      player2 = Player.new(25, 'Test name')
      @game.add_player(player2)

      expect(@game.players.length).to eq(2)
    end

    it 'player index is 0' do
      @game.add_player(@player)

      player2 = Player.new(25, 'Test name')
      @game.add_player(player2)

      expect(@player.index).to eq(0)
    end

    it 'player2 index is 0' do
      @game.add_player(@player)

      player2 = Player.new(25, 'Test name')
      @game.add_player(player2)

      expect(player2.index).to eq(1)
    end

    it 'count 0' do
      @game.status = Game::INPROGRESS
      @game.add_player(@player)

      expect(@game.players.length).to eq(0)
    end

    it 'game is not ready' do
      @game.status = Game::INPROGRESS
      status = @game.add_player(@player)

      expect(status).to eq('game is not ready')
    end

    it 'sorry max number of players is 6' do
      @game.status = Game::READY
      @game.add_player(@player)
      @game.add_player(Player.new(20, 'player 2'))
      @game.add_player(Player.new(20, 'player 3'))
      @game.add_player(Player.new(20, 'player 4'))
      @game.add_player(Player.new(20, 'player 5'))
      @game.add_player(Player.new(20, 'player 6'))

      expect(@game.add_player(Player.new(20, 'player 7'))).to eq('sorry max number of players is 6')
    end

    it 'game is not ready' do
      @game.status = Game::INPROGRESS
      @game.add_player(@player)

      expect(@game.add_player(@player)).to eq('game is not ready')
    end
  end

  describe 'remove player' do
    before :each do
      @game = Game.new
      @player = Player.new(10, 'Test name')
      @game.add_player(@player)
    end

    it 'there are not players' do
      @game.remove_player(@player.index)

      expect(@game.players).to be_empty
    end

    it 'players is 0' do
      @game.remove_player(@player.index)

      expect(@game.players.length).to eq(0)
    end

    it 'players not 1' do
      @game.remove_player(@player.index)

      expect(@game.players.length).to_not eq(1)
    end

    it 'both players removed: players length is 0' do
      player2 = Player.new(5, 'Test name')
      @game.add_player(player2)

      @game.remove_player(@player.index)
      @game.remove_player(player2.index)

      expect(@game.players.length).to eq(0)
    end

    it 'return player with money' do
      player_check = @game.remove_player(@player.index)

      expect(player_check.money).to eq(@player.money)
    end

    it 'return player incorrect amount of money' do
      player_check = @game.remove_player(@player.index)

      expect(player_check.money).to_not eq(2)
    end

    it 'return player not false' do
      player_check = @game.remove_player(@player.index)

      expect(player_check).to_not be_falsey
    end

    it 'return false no player at index' do
      player_check = @game.remove_player(2)

      expect(player_check).to be_falsey
    end

    it 'return false because in progress' do
      @game.status = Game::INPROGRESS
      player_check = @game.remove_player(2)

      expect(player_check).to be_falsey
    end

    it 'player cant leave because game in progress' do
      @game.status = Game::INPROGRESS
      @game.remove_player(1)

      expect(@game.players.length).to eq(1)
    end
  end

  describe 'players betted' do
    before :each do
      @game = Game.new

      player1 = Player.new(10, 'Test name')
      player2 = Player.new(10, 'Test name')

      @game.add_player(player1)
      @game.add_player(player2)
    end

    it 'all players' do
      @game.players[0].place_bet(1)
      @game.players[1].place_bet(1)

      expect(@game.player_betted).to be_truthy
    end

    it 'all players' do
      @game.players[1].place_bet(1)

      expect(@game.player_betted).to be_falsey
    end
  end

  describe 'deal' do
    before :each do
      @game = Game.new

      player1 = Player.new(10, 'Test name')
      player2 = Player.new(20, 'Test name')

      @game.add_player(player1)
      @game.add_player(player2)
      @game.get_decks(2)
    end

    describe 'valid' do
      before :each do
        allow(@game.cards).to receive(:get_number_of_cards).and_return(50)
        allow(@game.cards).to receive(:get_card).and_return(Card.new(0, 0))
      end

      it 'player1 has 2 cards' do
        @game.deal

        expect(@game.players[0].cards.length).to eq(2)
      end

      it 'player2 has 2 cards' do
        @game.deal

        expect(@game.players[1].cards.length).to eq(2)
      end

      it 'player1 has cards' do
        @game.deal

        expect(@game.players[0].cards).to_not be_empty
      end

      it 'player1 does not have 3 cards' do
        @game.deal
        expect(@game.players[0].cards.length).to_not eq(3)
      end

      it 'game status is in progress' do
        @game.deal
        expect(@game.status).to eq(Game::INPROGRESS)
      end

      it 'game status is not ready' do
        @game.deal
        expect(@game.status).to_not eq(Game::READY)
      end

      it 'player index is 0' do
        @game.deal
        expect(@game.player_i).to eq(0)
      end

      it 'player index is not -1' do
        @game.deal
        expect(@game.player_i).to_not eq(-1)
      end

      it 'dealder has 2 cards' do
        @game.deal
        expect(@game.dealer.cards.length).to eq(2)
      end

      it 'dealder does not have 0 cards' do
        @game.deal
        expect(@game.dealer.cards.length).to_not eq(0)
      end

      it 'player 1 score should be 0' do
        @game.players[0].score = 1
        @game.deal

        expect(@game.players[0].score).to eq(0)
      end

      it 'player 1 score should not be 0' do
        @game.players[0].score = 1
        @game.deal

        expect(@game.players[0].score).to_not eq(1)
      end

      it 'dealer score should be 0' do
        @game.dealer.score = 1
        @game.deal

        expect(@game.players[0].score).to eq(0)
      end

      it 'dealer score should not be 0' do
        @game.dealer.score = 1
        @game.deal

        expect(@game.dealer.score).to_not eq(1)
      end
    end
  end

  describe 'hit' do
    before :each do
      @game = Game.new
      @game.get_decks(2)

      player = Player.new(5, 'Test name')
      @game.add_player(player)

      player2 = Player.new(5, 'Test name')
      @game.add_player(player2)

      @game.status = Game::INPROGRESS
    end

    describe 'valid' do
      before :each do
        card = Card.new(0, 0)

        allow(@game.cards).to receive(:get_number_of_cards).and_return(50)
        allow(@game.cards).to receive(:get_card).and_return(card)
      end

      it 'player1 has 1 card' do
        @game.player_i = 0
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        @game.hit

        expect(@game.players[0].cards.length).to eq(1)
      end

      it 'player1 has 3 card' do
        @game.player_i = 0
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        @game.hit
        @game.hit
        @game.hit

        expect(@game.players[0].cards.length).to eq(3)
      end

      it 'player2 has 2 card' do
        @game.player_i = 1
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        @game.hit
        @game.hit

        expect(@game.players[1].cards.length).to eq(2)
      end

      it 'player2 has 2 card' do
        @game.player_i = 0
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        @game.hit
        @game.hit

        expect(@game.players[1].cards.length).to_not eq(2)
      end

      it 'player hit return true' do
        @game.player_i = 0
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        hit_return = @game.hit

        expect(hit_return).to be_truthy
      end

      it 'player hit return false' do
        @game.status = Game::READY
        @game.player_i = 0
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        hit_return = @game.hit

        expect(hit_return).to be_falsey
      end

      it 'dealer gets another card' do
        @game.status = Game::INPROGRESS
        @game.player_i = -1
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        hit_return = @game.hit

        expect(hit_return).to be_truthy
      end

      it 'dealer has 3 cards' do
        @game.status = Game::INPROGRESS
        @game.player_i = -1
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        @game.hit

        expect(@game.dealer.cards.length).to eq(1)
      end

      it 'dealer does not have 2 cards' do
        @game.status = Game::INPROGRESS
        @game.player_i = -1
        allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)
        @game.hit

        expect(@game.dealer.cards.length).to_not eq(0)
      end
    end

    it 'no cards to hit' do
      card = Card.new(0, 0)
      @game.player_i = 0

      allow(@game.cards).to receive(:get_number_of_cards).and_return(0)
      allow(@game.cards).to receive(:get_card).and_return(card)
      allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)

      hit_return = @game.hit

      expect(hit_return).to be_falsey
    end

    it 'no cards to hit' do
      @game.player_i = 0

      allow(@game.cards).to receive(:get_number_of_cards).and_return(50)
      allow(@game.cards).to receive(:get_card).and_return(false)
      allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(15)

      hit_return = @game.hit

      expect(hit_return).to be_falsey
    end

    it 'player busts' do
      @game.player_i = 0
      card = Card.new(0, 9) # 10

      allow(@game.cards).to receive(:get_number_of_cards).and_return(51)
      allow(@game.cards).to receive(:get_card).and_return(card)
      allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(22)

      @game.hit

      expect(@game.player_i).to eq(1)
    end

    it 'player gets 21: no longer player 1 turn' do
      @game.player_i = 0
      card = Card.new(0, 9) # 10

      allow(@game.cards).to receive(:get_number_of_cards).and_return(51)
      allow(@game.cards).to receive(:get_card).and_return(card)
      allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(21)

      @game.hit

      expect(@game.player_i).to_not eq(0)
    end

    it 'no longer player 1 turn' do
      @game.player_i = 0
      card = Card.new(0, 9) # 10

      allow(@game.cards).to receive(:get_number_of_cards).and_return(51)
      allow(@game.cards).to receive(:get_card).and_return(card)
      allow(@game).to receive(:calc_score).with(@game.players[@game.player_i].cards).and_return(23)

      @game.hit

      expect(@game.player_i).to_not eq(0)
    end
  end

  describe 'stand' do
    before :each do
      @game = Game.new

      player1 = Player.new(5, 'Test name')
      player2 = Player.new(10, 'Test name')

      @game.add_player(player1)
      @game.add_player(player2)

      @game.player_i = 0
      @game.status = Game::INPROGRESS
    end

    it 'player1 stand now player2 turn' do
      @game.stand

      expect(@game.player_i).to eq(1)
    end

    it 'player2 stand players done' do
      @game.stand
      @game.stand

      expect(@game.player_i).to eq(-1)
    end

    it 'no longer player 1 turn' do
      @game.stand

      expect(@game.player_i).to_not eq(0)
    end

    it 'dealer is done' do
      allow(@game).to receive(:cacl_players_score).and_return(true)
      allow(@game).to receive(:player_wins)
      @game.stand
      @game.stand
      @game.stand

      expect(@game.status).to eq(Game::OVER)
    end

    it 'stand return false because game is not in prog' do
      @game.status = Game::READY
      stand_return = @game.stand

      expect(stand_return).to be_falsey
    end

    it 'player_i is still 0 because game is not in prog' do
      @game.status = Game::READY
      @game.stand

      expect(@game.player_i).to eq(0)
    end
  end

  describe 'double_down' do
    before :each do
      @game = Game.new

      player1 = Player.new(5, ' Test name')
      player2 = Player.new(10, 'Test name')

      @game.add_player(player1)
      @game.add_player(player2)

      @game.players[0].place_bet(2)
      @game.players[1].place_bet(10)
      @game.get_decks(1)
      @game.deal
    end

    it 'player1 doubles down' do
      expect(@game.double_down).to be_truthy
    end

    it 'player2 fails at double down' do
      @game.double_down
      expect(@game.double_down).to be_falsey
    end

    it 'player1 doubles down card length 3' do
      @game.double_down
      expect(@game.players[0].cards.length).to eq(3)
    end
  end

  describe 'calc_score' do
    before :each do
      @game = Game.new
      player = Player.new(5, 'Test name')
      @game.add_player(player)
    end

    it '2 + 5 = 7' do
      card_2 = Card.new(0, 1)
      card_5 = Card.new(0, 4)

      @game.players[0].cards = [card_2, card_5]

      expect(@game.calc_score(@game.players[0].cards)).to eq(7)
    end

    it 'K + J = 20' do
      card_k = Card.new(0, 12)
      card_j = Card.new(0, 10)

      @game.players[0].cards = [card_k, card_j]

      expect(@game.calc_score(@game.players[0].cards)).to eq(20)
    end

    it 'K + A = 21' do
      card_k = Card.new(0, 12)
      card_a = Card.new(0, 0)

      @game.players[0].cards = [card_k, card_a]

      expect(@game.calc_score(@game.players[0].cards)).to eq(21)
    end

    it '2 + 5 + 10 = 17' do
      card_2 = Card.new(0, 1)
      card_5 = Card.new(0, 4)
      card_10 = Card.new(0, 9)

      @game.players[0].cards = [card_2, card_5, card_10]

      expect(@game.calc_score(@game.players[0].cards)).to eq(17)
    end

    it '5 + 8 + 10 = 23' do
      card_5 = Card.new(0, 4)
      card_8 = Card.new(0, 7)
      card_10 = Card.new(0, 9)

      @game.players[0].cards = [card_5, card_8, card_10]

      expect(@game.calc_score(@game.players[0].cards)).to eq(23)
    end

    it '2 + 5 + 10 + 4 = 21' do
      card_2 = Card.new(0, 1)
      card_5 = Card.new(0, 4)
      card_10 = Card.new(0, 9)
      card_4 = Card.new(0, 3)

      @game.players[0].cards = [card_2, card_5, card_10, card_4]

      expect(@game.calc_score(@game.players[0].cards)).to eq(21)
    end

    it '2 + 5 + 10 + 7 = 24' do
      card_2 = Card.new(0, 1)
      card_5 = Card.new(0, 4)
      card_10 = Card.new(0, 9)
      card_7 = Card.new(0, 6)

      @game.players[0].cards = [card_2, card_5, card_10, card_7]

      expect(@game.calc_score(@game.players[0].cards)).to eq(24)
    end

    it '9 + A + 4 = 14' do
      card_9 = Card.new(0, 8)
      card_a = Card.new(0, 0)
      card_4 = Card.new(0, 3)

      @game.players[0].cards = [card_9, card_a, card_4]

      expect(@game.calc_score(@game.players[0].cards)).to eq(14)
    end

    it '8 + A + 6 = 15' do
      card_8 = Card.new(0, 7)
      card_a = Card.new(0, 0)
      card_6 = Card.new(0, 5)

      @game.players[0].cards = [card_8, card_a, card_6]

      expect(@game.calc_score(@game.players[0].cards)).to eq(15)
    end

    it '2 + 5 + 10 + 4 = 21' do
      card_2 = Card.new(0, 1)
      card_5 = Card.new(0, 4)
      card_10 = Card.new(0, 9)
      card_4 = Card.new(0, 3)

      @game.dealer.cards = [card_2, card_5, card_10, card_4]

      expect(@game.calc_score(@game.dealer.cards)).to eq(21)
    end

    it '2 + 5 + 10 + 7 = 24' do
      card_2 = Card.new(0, 1)
      card_5 = Card.new(0, 4)
      card_10 = Card.new(0, 9)
      card_7 = Card.new(0, 6)

      @game.dealer.cards = [card_2, card_5, card_10, card_7]

      expect(@game.calc_score(@game.dealer.cards)).to eq(24)
    end

    it '9 + A + 4 = 14' do
      card_9 = Card.new(0, 8)
      card_a = Card.new(0, 0)
      card_4 = Card.new(0, 3)

      @game.dealer.cards = [card_9, card_a, card_4]

      expect(@game.calc_score(@game.dealer.cards)).to eq(14)
    end

    it '8 + A + 6 = 15' do
      card_8 = Card.new(0, 7)
      card_a = Card.new(0, 0)
      card_6 = Card.new(0, 5)

      @game.dealer.cards = [card_8, card_a, card_6]

      expect(@game.calc_score(@game.dealer.cards)).to eq(15)
    end
  end

  describe 'cacl_players_score' do
    before :each do
      @game = Game.new
      player = Player.new(5, 'Test name')
      @game.add_player(player)
    end

    it 'player has score' do
      @game.status = Game::OVER
      allow(@game).to receive(:calc_score).with(@game.players[0].cards).and_return(14)
      allow(@game).to receive(:calc_score).with(@game.dealer.cards).and_return(17)
      @game.cacl_players_score
      expect(@game.players[0].score).to_not be_nil
    end

    it 'return true' do
      @game.status = Game::OVER
      allow(@game).to receive(:calc_score).with(@game.players[0].cards).and_return(14)
      allow(@game).to receive(:calc_score).with(@game.dealer.cards).and_return(17)
      @game.cacl_players_score
      expect(@game.cacl_players_score).to be_truthy
    end

    it 'dealer has score' do
      @game.status = Game::OVER
      allow(@game).to receive(:calc_score).with(@game.players[0].cards).and_return(14)
      allow(@game).to receive(:calc_score).with(@game.dealer.cards).and_return(17)
      @game.cacl_players_score
      expect(@game.dealer.score).to_not be_nil
    end

    it 'dealer has score of 17' do
      @game.status = Game::OVER
      allow(@game).to receive(:calc_score).with(@game.players[0].cards).and_return(14)
      allow(@game).to receive(:calc_score).with(@game.dealer.cards).and_return(17)
      @game.cacl_players_score
      expect(@game.dealer.score).to eq(17)
    end
  end

  describe 'player_wins' do
    before :each do
      @game = Game.new
      player = Player.new(5, 'Test name')
      @game.add_player(player)
    end

    it 'player wins 20 vs dealer 19' do
      @game.players[0].score = 20
      @game.dealer.score = 19
      @game.players[0].bet = 5
      @game.player_wins

      expect(@game.players[0].money).to eq(15)
    end

    it 'player busts' do
      @game.players[0].score = 22
      @game.dealer.score = 19
      @game.players[0].bet = 5
      @game.player_wins

      expect(@game.players[0].money).to eq(5)
    end

    it 'delaer busts' do
      @game.players[0].score = 17
      @game.dealer.score = 24
      @game.players[0].bet = 5
      @game.player_wins

      expect(@game.players[0].money).to eq(15)
    end

    it 'both bust' do
      @game.players[0].score = 23
      @game.dealer.score = 24
      @game.players[0].bet = 5
      @game.player_wins

      expect(@game.players[0].money).to eq(5)
    end

    it 'player loses 17 vs dealer 20' do
      @game.players[0].score = 17
      @game.dealer.score = 20
      @game.players[0].bet = 5
      @game.player_wins

      expect(@game.players[0].money).to eq(5)
    end
  end

  describe 'blackjack?' do
    before :each do
      @game = Game.new
      player = Player.new(5, 'Test name')
      @game.add_player(player)
    end

    it 'has blackjack' do
      card_1 = Card.new(0, 0)
      card_2 = Card.new(0, 10)
      @game.players[0].cards = [card_1, card_2]
      expect(@game.blackjack?(0)).to be_truthy
    end

    it 'does not blackjack' do
      card_1 = Card.new(0, 1)
      card_2 = Card.new(0, 10)
      @game.players[0].cards = [card_1, card_2]
      expect(@game.blackjack?(0)).to be_falsey
    end

    it 'does not blackjack' do
      card_1 = Card.new(0, 7)
      card_2 = Card.new(0, 8)
      card_3 = Card.new(0, 3)
      @game.players[0].cards = [card_1, card_2, card_3]
      expect(@game.blackjack?(0)).to be_falsey
    end
  end

  describe 'to_s' do
    before :each do
      @game = Game.new
      player = Player.new(5, 'Test name')
      @game.add_player(player)
    end

    it 'eq to "test has [Ace of Spaids, 6 of Dimonds]"' do
      expect(@game.to_s).to_not be_empty
    end
  end
end
