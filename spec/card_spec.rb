#!/usr/bin/ruby

require_relative "./spec_helper"
require_relative '../card.rb'

describe "card" do
  describe "init" do 
    it "suit is 1" do 
      card = Card.new(1,2)

      expect(card.suit).to eq(1)
    end

    it "number is 2" do 
      card = Card.new(1,2)

      expect(card.number).to eq(2)
    end

    it "suit is not 1" do 
      card = Card.new(1,2)

      expect(card.suit).to_not eq(2)
    end

    it "number is not 1" do 
      card = Card.new(1,2)

      expect(card.number).to_not eq(1)
    end

    it "suit is invalid: too little" do 
      card = Card.new(-1,2)

      expect(card.suit).to be_nil
    end

    it "suit is invalid: too large" do 
      card = Card.new(4,2)

      expect(card.suit).to be_nil
    end

    it "number is invalid: too little" do 
      card = Card.new(1,-1)

      expect(card.number).to be_nil
    end

    it "number is invalid: too large" do 
      card = Card.new(1,13)

      expect(card.number).to be_nil
    end
  end

  describe "to_s" do
    it "card is equal to Ace of Spaids" do 
      card = Card.new(0,0)

      expect(card.to_s).to eq('Ace of Spaids')
    end

    it "card is equal to 5 of Hearts" do 
      card = Card.new(1,4)

      expect(card.to_s).to eq('5 of Hearts')
    end

    it "card is equal to Jack of Clubs" do 
      card = Card.new(2,10)

      expect(card.to_s).to eq('Jack of Clubs')
    end

    it "card is equal to Queen of Clubs" do 
      card = Card.new(2,11)

      expect(card.to_s).to eq('Queen of Clubs')
    end

   it "card is equal to King of Dimaonds" do 
      card = Card.new(3,12)

      expect(card.to_s).to eq('King of Dimonds')
    end

    it "card is equal not to 10 of Dimaonds" do 
      card = Card.new(3,9)

      expect(card.to_s).to_not eq('King of Dimonds')
    end

    it "card is equal not to 7 of Clubs" do 
      card = Card.new(2,7)

      expect(card.to_s).to_not eq('7 of Clubs')
    end

    it "card is equal not to 2 of Hearts" do 
      card = Card.new(1,2)

      expect(card.to_s).to_not eq('2 of Hearts')
    end

    it "card is equal not to 4 of Clubs" do 
      card = Card.new(0,7)

      expect(card.to_s).to_not eq('4 of Clubs')
    end

    it "card is invalid: suit too low" do 
      card = Card.new(-1,7)

      expect(card.to_s).to eq('invalid card')
    end

    it "card is invalid: suit too high" do 
      card = Card.new(1,13)

      expect(card.to_s).to eq('invalid card')
    end

    it "card is invalid: number too low" do 
      card = Card.new(1,-1)

      expect(card.to_s).to eq('invalid card')
    end

    it "card is invalid: number too high" do 
      card = Card.new(1,13)

      expect(card.to_s).to eq('invalid card')
    end
  end

  describe "==" do
    it "card number is equal to other" do 
      card = Card.new(0,0)
      card2 = Card.new(0,0)

      expect(card == card2).to be_truthy
    end

    it "card number is equal to other" do 
      card = Card.new(0,0)
      card2 = Card.new(2,0)

      expect(card == card2).to be_truthy
    end

    it "card number is equal to other" do 
      card = Card.new(0,0)
      card2 = Card.new(2,1)

      expect(card == card2).to be_falsey
    end
  end

  describe "!=" do
    it "card number is not equal to other" do 
      card = Card.new(1,1)
      card2 = Card.new(0,0)

      expect(card != card2).to be_truthy
    end

    it "card number is not equal to other" do 
      card = Card.new(3,10)
      card2 = Card.new(2,0)

      expect(card != card2).to be_truthy
    end

    it "card number is not equal to other" do 
      card = Card.new(1,0)
      card2 = Card.new(2,0)

      expect(card != card2).to be_falsey
    end
  end
end
