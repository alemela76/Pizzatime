#!/usr/bin/env ruby

require_relative '../lib/inputread'
data = Input.new(ARGV[0].to_s)
rows = data.rows
#puts "rows = #{data.rows}"
columns = data.columns
#puts "columns = #{data.columns}"
minelements = data.minelements
#puts "minelements = #{data.minelements}"
maxpieces = data.maxpieces
#puts "maxpieces = #{data.maxpieces}"

r = 0
@pieces = data.pizzapieces

while r < rows.to_i
	c = 0
	while c < columns.to_i
		puts "value row#{r} column#{c} = #{@pieces[[r,c]]}"
		c += 1
	end
	r += 1
end