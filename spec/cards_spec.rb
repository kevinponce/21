#!/usr/bin/ruby

require_relative './spec_helper'
require_relative '../cards.rb'

describe 'cards' do
  describe 'init' do 
    it 'number of decks is 0' do 
      cards = Cards.new

      expect(cards.number_of_decks).to eq(0)
    end

    it 'number of decks is not 2' do 
      cards = Cards.new

      expect(cards.number_of_decks).to_not eq(2)
    end

   it 'cards is empty' do 
      cards = Cards.new

      expect(cards.stack).to be_empty
    end
  end

  describe 'fresh_cards' do
    before :each do
      @cards = Cards.new
    end

    it 'number of decks is 3' do
      @cards.fresh_cards(3)

      expect(@cards.number_of_decks).to eq(3)
    end

    it 'number of decks is not 2' do
      @cards.fresh_cards(1)

      expect(@cards.number_of_decks).to_not eq(2)
    end

    it 'cards is not empty' do
      @cards.fresh_cards(3)

      expect(@cards.stack).to_not be_empty
    end

    it 'cards has 52 cards' do
      @cards.fresh_cards(1)

      expect(@cards.stack.length).to eq(52)
    end

    it 'cards does not have 52 cards' do
      @cards.fresh_cards(2)

      expect(@cards.stack.length).to_not eq(52)
    end

    it 'cards has 104 cards' do
      @cards.fresh_cards(2)

      expect(@cards.stack.length).to eq(104)
    end

    it 'cards has 156 cards' do
      @cards.fresh_cards(3)

      expect(@cards.stack.length).to eq(156)
    end
  end

  describe 'get_card' do
    describe 'fresh_cards' do
      before :each do
        @cards = Cards.new
        @cards.fresh_cards(1)
      end
 
      it 'get card cards should have 51 cards' do 
        card = @cards.get_card
 
        expect(@cards.stack.length).to eq(51)
      end

      it 'get card cards should not have 52 cards' do 
        card = @cards.get_card

        expect(@cards.stack.length).to_not eq(52)
      end
    end

    it 'get card cards should not have 52 cards' do 
      cards = Cards.new
      card = cards.get_card

      expect(cards.stack.length).to_not eq(52)
    end
  
    it 'get card cards should not have 52 cards' do 
      cards = Cards.new
      card = cards.get_card

      expect(card).to be_falsey
    end
  end

  describe 'add_card' do
    before :each do
      @cards = Cards.new
      @cards.fresh_cards(1)
      @card = @cards.get_card
    end

    it 'cards count is 51' do 
      expect(@cards.stack.length).to eq(51)
    end

    it 'cards count is 52' do 
      @cards.add_card(@card)

      expect(@cards.stack.length).to eq(52)
    end

    it 'cards count is not 51' do 
      @cards.add_card(@card)

      expect(@cards.stack.length).to_not eq(51)
    end
  end

  describe 'add_cards' do
    before :each do
      @cards = Cards.new
      @cards.fresh_cards(1)
      card1 = @cards.get_card
      card2 = @cards.get_card
      card3 = @cards.get_card

      @cards_list = [card1, card2, card3]
    end

    it 'cards count is 49' do 
      expect(@cards.stack.length).to eq(49)
    end

    it 'cards count is 52' do 
      @cards.add_cards(@cards_list)

      expect(@cards.stack.length).to eq(52)
    end

    it 'cards count is not 51' do 
      @cards.add_cards(@cards_list)

      expect(@cards.stack.length).to_not eq(51)
    end
  end

  describe 'get_number_of_cards' do
    before :each do
      @cards = Cards.new
      @cards.fresh_cards(1)
    end

    it 'cards count is 49' do 
      card1 = @cards.get_card
      card2 = @cards.get_card
      card3 = @cards.get_card

      expect(@cards.get_number_of_cards).to eq(49)
    end

    it 'cards count is 51' do 
      card1 = @cards.get_card

      expect(@cards.get_number_of_cards).to eq(51)
    end

    it 'cards count is not 51' do 
      card1 = @cards.get_card
      card2 = @cards.get_card
      card3 = @cards.get_card

      expect(@cards.get_number_of_cards).to_not eq(51)
    end
  end

  describe 'shuffle' do
    before :each do
      @deck1 = Cards.new
      @deck1.fresh_cards(1)

      @deck2 = Cards.new
      @deck2.fresh_cards(1)
    end

    it 'cards is shuffled' do 
      @deck2.shuffle!(1)
      shuffled = false

      for i in 0..51
        if !shuffled && @deck1.stack[i] != @deck2.stack[i]
          shuffled = true
        end
      end      

      expect(shuffled).to be_truthy
    end

    it 'cards is not shuffled' do 
      shuffled = false

      for i in 0..51
        if !shuffled && @deck1.stack[i] != @deck2.stack[i]
          shuffled = true
        end
      end      

      expect(shuffled).to be_falsey
    end

    it 'cards length should still be 52' do 
      @deck1.shuffle!(3)
      expect(@deck1.get_number_of_cards).to eq(52)
    end
  end
end
