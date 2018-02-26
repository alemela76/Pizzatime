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
#	puts "this is solution #{solut}"
	while i < cells
		sum = sum + @pieces[solut[i]].to_i
#		puts "piece is #{solut[i]} and has value #{@pieces[solut[i]].to_i}"
#		puts "partial sum is #{sum}"
		i +=1
	end
	if sum >= @minelements.to_i
		rest = cells - sum
		if rest >= @minelements.to_i
#		  puts "totalsum is #{sum}"
#			puts "rest is #{rest}"
			return 0
		end
	else
		return 1
	end
end
####

#checks all the possible pieces fitting the specs
trozo = Array.new
goodslices = Array.new
r = 0
i = 0
k = 0
while r < @rows.to_i
	c = 0
	while c < @columns.to_i
#		puts "value row#{r} column#{c} = #{@pieces[[r,c]]}"
		j = 0
		while j < @shapesnum
			wh = @shape.shapes.keys[j]
			w = wh[0]
			h = wh[1]
			if fits(c,r,w,h) == 0
#				puts "shape #{w} x #{h} starting in #{c},#{r} fits"
				trozos = Sliceshapes.new(c, r, w, h)
				trozo[i] = trozos.listcells
#				puts "slicesolution #{i} is #{trozo[i]}"
				if isvalid(trozo[i]) == 0
#					puts "slicesolution #{i} is valid"
#					puts "slicesolution #{i} is #{trozo[i]}"
					goodslices[k] = trozos.listcells
					k +=1
				end
#				puts "slicesolution #{i} is #{trozo[i]}"
				i +=1
			end
			j +=1
		end	  			
		c += 1
	end
	r += 1
end

possiblesolutions = Array.new
validslices = goodslices.length
#puts "valid slices= #{validslices}"
size = 0
while size < validslices
#	puts goodslices[0]
	size +=1
	possiblesolutions << goodslices.combination(size).to_a
#	puts goodslices
#	puts possiblesolutions
end

def intersect(solut)
	cont1 = 0
	slicesnumber = soluts.length
	while cont1 < slicesnumber
		cont2 = cont1 + 1
		while cont2 < slicesnumber
			if !(soluts[cont1] & soluts[cont2]).empty?
				return 1
				break
			end
			cont2 +=1
		end
		cont1 +=1
	end
	return 0
end

numsolutions = possiblesolutions.length
cont = 0
goodsolutions = Array.new

while cont < numsolutions
	if intersect(possiblesolutions[cont]) == 0
		goodsolutions << possiblesolutions[cont]
	end
	cont +=1
end

def selectsolution(goodsol)
	slices = Array.new
	numsol = goodsol.length
	biggerarea = 0
	numslices = 0
	minslices = 0
	count1 = 0
	while count1 < numsol
	 	area = 0
		count2 = 0
		numslices = goodsol[count1].length
		while count2 < numslices
			area = area + goodsol[count2].length
			count2 +=1
		end
		if area > biggerarea
			minslices == numslices
			biggerarea = area
			solution = goodsol[count1]
		elsif area == biggerarea
			if minslices > numslices
				minslices == numslices
				solution = goodsol[count1]
			end
		end
	count1 +=1
	end
	return solution
end

puts selectsolution(goodsolutions)