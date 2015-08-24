#!/usr/bin/ruby

require_relative './spec_helper'
require_relative '../object'

describe 'object' do
  describe 'is_number?'do
    it '1 is numberic' do
      expect(1.is_number?).to be_truthy
    end

    it '7 is numberic' do
      expect(7.is_number?).to be_truthy
    end

    it 'x is not numberic' do
      expect('x'.is_number?).to be_falsey
    end

    it '1x is not numberic' do
      expect('1x'.is_number?).to be_falsey
    end
  end
end
