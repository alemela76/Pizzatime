#!/usr/bin/env ruby

require_relative '../lib/inputread'
require_relative '../lib/slices'
require_relative '../lib/slicells'

data = Input.new(ARGV[0].to_s)
@rows = data.rows
puts "rows = #{@rows}"
@columns = data.columns
puts "columns = #{@columns}"
@minelements = data.minelements
puts "minelements = #{@minelements}"
@maxpieces = data.maxpieces
puts "maxpieces = #{@maxpieces}"
@pieces = data.pizzapieces

@shape = Slices.new(@maxpieces, @minelements)
@shapesnum = @shape.shapesnumber

def fits(x,y,sidex,sidey)
	if (x.to_i + sidex.to_i) <= (@columns.to_i)
		if (y.to_i + sidey.to_i) <= (@rows.to_i)
			return 0
		end
	else
		return 1
	end
end

###review this
def isvalid(solut)
	cells = solut.length
	sum = 0
	rest = 0
	i = 0
	while i < cells
		sum = sum + @pieces[solut[i]].to_i
		i +=1
	end
	if sum >= @minelements.to_i
		rest = cells - sum
		if rest >= @minelements.to_i
			return 0
		end
	else
		return 1
	end
end
####


#checks
solution = Array.new
counter = 0
r = 0
i = 0
while r < @rows.to_i
	c = 0
	while c < @columns.to_i
		j = 0
		while j < @shapesnum
			wh = @shape.shapes.keys[j]
			w = wh[0]
			h = wh[1]
			if fits(c,r,w,h) == 0
#				puts "shape #{w} x #{h} starting in #{c},#{r} fits"
				trozo = Sliceshapes.new(c, r, w, h)
				solution[i] = trozo.listcells
				if isvalid(solution[i]) == 0
					puts "solution #{i} is valid"
					puts "solution #{i} is #{solution[i]}"
				end
#				puts "solution #{i} is #{solution[i]}"
				i +=1
			end
			j +=1
		end	  			
#		puts "value row#{r} column#{c} = #{@pieces[[r,c]]}"
		c += 1
	end
	r += 1
end

