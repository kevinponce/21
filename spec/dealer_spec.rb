#!/usr/bin/ruby

require_relative "./spec_helper"
require_relative "../dealer"
require_relative "../card"

describe 'dealer' do
  describe 'init' do
    it "has no cards" do 
      dealer = Dealer.new

      expect(dealer.cards).to be_empty
    end

    it 'score should be 0' do
      dealer = Dealer.new

     expect(dealer.score).to eq(0)
    end

    it 'score should not be 0' do
      dealer = Dealer.new

     expect(dealer.score).to_not eq(1)
    end    
  end

  describe 'add card' do
    before :each do 
      @dealer = Dealer.new
    end

    it 'should not be empty' do 
      card = Card.new(0,0)
      
      @dealer.add_card(card);

      expect(@dealer.cards).to_not be_empty
    end

    it 'should have 1 card' do
      card = Card.new(1,1)

      @dealer.add_card(card)

      expect(@dealer.cards.length).to eq(1)
    end

    it 'should have 2 cards' do
      card1 = Card.new(1,1)
      card2 = Card.new(2,2)
    
      @dealer.add_card(card1)
      @dealer.add_card(card2)

      expect(@dealer.cards.length).to eq(2)
    end

    it 'should not have 1 card' do
      card1 = Card.new(1,1)
      card2 = Card.new(2,2)
    
      @dealer.add_card(card1)
      @dealer.add_card(card2)

      expect(@dealer.cards.length).to_not eq(1)
    end
  end
 
  describe 'remove cards ' do
    before :each do
      @dealer = Dealer.new
      @card1 = Card.new(0,9)

      @dealer.cards  = [@card1,@card1,@card1]
    end

    it 'cards empty' do 
      @dealer.remove_cards

      expect(@dealer.cards).to be_empty
    end

    it 'length is 0' do
      @dealer.remove_cards
   
      expect(@dealer.cards.length).to eq(0)
    end

    it 'length is not 3' do 
      @dealer.remove_cards

      expect(@dealer.cards.length).to_not eq(3)
    end

    it 'return card length 3' do 
      card_check = @dealer.remove_cards

      expect(card_check.length).to eq(3)
    end

    it 'return card length is not 0' do
      card_check = @dealer.remove_cards

      expect(card_check.length).to_not eq(2)
    end

    it 'card matches' do
      card_check = @dealer.remove_cards

      expect(card_check[0]).to eq(@card1)
    end 

    it 'card dont matches' do
      card_check = @dealer.remove_cards
 
      card2 = Card.new(1,1)

      expect(card_check[0]).to_not eq(card2)
    end 
  end

  describe 'to_s' do
    before :each do 
      @dealer = Dealer.new
    end

    it 'eq to "Dealer has [Ace of Spaids, 6 of Dimonds]"' do
       card_1 = Card.new(0,0)
       card_2 = Card.new(3,5)
       @dealer.cards = [card_1,card_2];
  
       expect(@dealer.to_s).to eq("Dealer has Ace of Spaids, 6 of Dimonds");
    end

    it 'eq to "Dealer has 4 of Hearts, 8 of Clubs and wins"' do
       card_1 = Card.new(1,3)
       card_2 = Card.new(2,7)
       @dealer.cards = [card_1,card_2];
  
       expect(@dealer.to_s).to eq("Dealer has 4 of Hearts, 8 of Clubs");
    end

    it 'eq to "Dealer has 4 of Hearts, 8 of Clubs, Jack of Spaids and busts"' do
       card_1 = Card.new(1,3)
       card_2 = Card.new(2,7)
       card_3 = Card.new(0,10)
       @dealer.cards = [card_1,card_2,card_3];
       @dealer.status = 'busts'
  
       expect(@dealer.to_s).to eq("Dealer has 4 of Hearts, 8 of Clubs, Jack of Spaids and busts");
    end
  end
end
