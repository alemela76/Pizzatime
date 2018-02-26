#!/usr/bin/env ruby

Sliceshapes = Struct.new(:x,:y,:width,:height) do
	
	def cutcells
		h = 0
		while h < height.to_i
			w = 0
			while w < width.to_i
				hcell = height.to_i + h.to_i
				wcell = width.to_i + w.to_i
				@slice[[hcell,wcell]] = "X"
				w += 1
			end
			h += 1
		end
		return @slice
	end
	
	def listcells
		@bits = Array.new
		i = 0
		h = 0
		while h < height.to_i
			w = 0
			while w < width.to_i
				hcell = h.to_i + y.to_i
				wcell = w.to_i + x.to_i
				@bits[i] = [wcell, hcell]
				w += 1
				i += 1
			end
			h += 1
		end
		return @bits
	end
	
	def outputformat
		endx = x.to_i + height.to_i - 1
		endy = y.to_i + width.to_i - 1
		string = x.to_s + " " + y.to_s + " " + endx.to_s + " " + endy.to_s
		return string
	end

end