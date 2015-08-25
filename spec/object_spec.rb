#!/usr/bin/ruby

require_relative './spec_helper'
require_relative '../object'

describe 'object' do
  describe 'number?'do
    it '1 is numberic' do
      expect(1.number?).to be_truthy
    end

    it '7 is numberic' do
      expect(7.number?).to be_truthy
    end

    it 'x is not numberic' do
      expect('x'.number?).to be_falsey
    end

    it '1x is not numberic' do
      expect('1x'.number?).to be_falsey
    end
  end
end
