#!/usr/bin/ruby

require_relative "./spec_helper"
require_relative "../player"
require_relative "../card"

describe 'player' do
  describe 'init' do
    it "has no cards" do 
      player = Player.new(20)

      expect(player.cards).to be_empty
    end

    it "has 20 dollars" do 
      player = Player.new(20)

      expect(player.money).to eq(20)
    end

    it "has 25 dollars" do 
      player = Player.new(25)

      expect(player.money).to eq(25)
    end

    it "does not have 10 dollars" do 
      player = Player.new(5)

      expect(player.money).to_not eq(10)
    end

    it "has 0 dollars" do 
      player = Player.new('x')

      expect(player.money).to eq(0)
    end
 
    it "index is nil" do 
      player = Player.new(10)
      
      expect(player.index).to be_nil
    end

    it 'bet should be 0' do
      player = Player.new(5)

     expect(player.bet).to eq(0)
    end

    it 'bet should not be 5' do
      player = Player.new(5)

     expect(player.bet).to_not eq(5)
    end

    it 'score should be 0' do
      player = Player.new(5)

     expect(player.score).to eq(0)
    end

    it 'score should not be 0' do
      player = Player.new(5)

     expect(player.score).to_not eq(1)
    end
  end

  describe 'add_money' do 
    before :each do
      @player = Player.new(5)
    end

    it 'should have 10 dollars' do 
      @player.add_money(5)

      expect(@player.money).to eq(10)
    end

    it 'should have 20 dollars' do
      @player.add_money(15)

      expect(@player.money).to eq(20)
    end

    it 'should not have 15 dollars' do
      @player.add_money(15)
    
      expect(@player.money).to_not eq(15)
    end

    it 'invalid money: should have 5 dollars' do
      @player.add_money('x')

      expect(@player.money).to eq(5)
    end
  end

  describe 'place_bet' do
    before :each do
      @player = Player.new(5)
    end

    it 'bet is 5 dollars' do
      @player.place_bet(5)

      expect(@player.bet).to eq(5)
    end

    it 'money is 0 after 5 dollar bet' do
      @player.place_bet(5)

      expect(@player.money).to eq(0)
    end

    it 'money is not 5 dollar after 5 dollar bet' do
      @player.place_bet(5)

      expect(@player.money).to_not eq(5)
    end

    it 'bet is not 0 dollars' do
      @player.place_bet(5)

      expect(@player.bet).to_not eq(0)
    end

    it 'bet return true' do
      bet_resp = @player.place_bet(5)

      expect(bet_resp).to be_truthy
    end

    it 'bet too large: return false' do
      bet_resp = @player.place_bet(10)

      expect(bet_resp).to be_falsey
    end

    it 'invalid bet: return false' do
      bet_resp = @player.place_bet('a')

      expect(bet_resp).to be_falsey
    end

    it 'invalid bet: return false' do
      bet_resp = @player.place_bet(2.4)

      expect(bet_resp).to be_truthy
    end

    it 'add to bet returns true' do
      bet_resp = @player.place_bet(1)
      bet_resp = @player.place_bet(1)

      expect(bet_resp).to be_truthy
    end

    it 'add to bet bet is 2 dollars' do
      bet_resp = @player.place_bet(1)
      bet_resp = @player.place_bet(1)

      expect(@player.bet).to eq(2)
    end

    it 'add to bet money is now 3 dollars' do
      bet_resp = @player.place_bet(1)
      bet_resp = @player.place_bet(1)

      expect(@player.money).to eq(3)
    end
  end

  describe 'add card' do
    before :each do 
      @player = Player.new(20)
    end

    it 'should not be empty' do 
      card = Card.new(0,0)
      
      @player.add_card(card);

      expect(@player.cards).to_not be_empty
    end

    it 'should have 1 card' do
      card = Card.new(1,1)

      @player.add_card(card)

      expect(@player.cards.length).to eq(1)
    end

    it 'should have 2 cards' do
      card1 = Card.new(1,1)
      card2 = Card.new(2,2)
    
      @player.add_card(card1)
      @player.add_card(card2)

      expect(@player.cards.length).to eq(2)
    end

    it 'should not have 1 card' do
      card1 = Card.new(1,1)
      card2 = Card.new(2,2)
    
      @player.add_card(card1)
      @player.add_card(card2)

      expect(@player.cards.length).to_not eq(1)
    end
  end
 
  describe 'remove cards ' do
    before :each do
      @player = Player.new(5)
      @card1 = Card.new(0,9)

      @player.cards  = [@card1,@card1,@card1]
    end

    it 'cards empty' do 
      @player.remove_cards

      expect(@player.cards).to be_empty
    end

    it 'length is 0' do
      @player.remove_cards
   
      expect(@player.cards.length).to eq(0)
    end

    it 'length is not 3' do 
      @player.remove_cards

      expect(@player.cards.length).to_not eq(3)
    end

    it 'return card length 3' do 
      card_check = @player.remove_cards

      expect(card_check.length).to eq(3)
    end

   it 'return card length is not 0' do
     card_check = @player.remove_cards

     expect(card_check.length).to_not eq(2)
   end

   it 'card matches' do
     card_check = @player.remove_cards

     expect(card_check[0]).to eq(@card1)
   end 

   it 'card dont matches' do
     card_check = @player.remove_cards
 
     card2 = Card.new(1,1)

     expect(card_check[0]).to_not eq(card2)
   end 
  end
end
