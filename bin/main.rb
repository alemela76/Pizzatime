#!/usr/bin/env ruby

require_relative '../lib/inputread'
data = Input.new(ARGV[0].to_s)
puts "rows =#{data.rows}"
puts "columns =#{data.columns}"
puts "minelements =#{data.minelements}"
puts "maxpieces =#{data.maxpieces}"