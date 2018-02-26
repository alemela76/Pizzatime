#!/usr/bin/env ruby

Slices = Struct.new(:maxsize, :minelements) do

	def shapes
		w = 1
		minarea = minelements.to_i*2
		@shape = Hash.new
		while w <= maxsize.to_i
			h = maxsize.to_i
			while h >= 1
				area = w * h
				if area >= minarea.to_i 
				  if area <=maxsize.to_i
						@shape[[w,h]] = area
					end
				end
				h -=1
			end
			w +=1
		end
		return @shape
	end
	
	def shapesnumber
		number = shapes.length
		return number
	end

end