#!/usr/bin/ruby

# object.rb
class Object
  def number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end
