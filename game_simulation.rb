#!/usr/bin/ruby

require_relative "./player"
require_relative "./game"

player1 = Player.new(20)
player2 = Player.new(20)
player3 = Player.new(20)

game = Game.new()
game.get_decks(1)

game.add_player(player1)
game.add_player(player2)
game.add_player(player3)


game.players.each do |player|
  player.place_bet(5)
end


p game.status

p game.deal

p game.status

p game.player_i

p game.stand #player 1

p game.hit
p game.stand #player 2
p game.stand #player 3
p game.stand #dealer


