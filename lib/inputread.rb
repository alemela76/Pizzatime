#!/usr/bin/env ruby
# expects a file with full path as input 

Input = Struct.new(:path) do
	
	def checks
		#check number of input parameters
		if ARGV.length < 1
			puts "there are not enough input parameters"
			exit 1
		elsif ARGV.length > 1
			puts "there are too many parameters"
			exit 1
		#check if parameter exist and is not directory
		elsif File.directory?(path.to_s)
			puts "the input is a directory, please specify a file"
			exit 1
		elsif	!File.exist?(path.to_s)
			puts "the input file does not exist"
			exit 1
		else 
			return 0
		end
	end
	
	def read_file(fichero)
		if checks == 0
			file = File.open(fichero, "r")
			data = file.read
			file.close
			return data
		end
	end

	def rows
		datos = read_file(path)
		datos.each_line	do |line|
			if line.strip.length == 7 && line.strip =~ / /
				values = line.split(' ')
				rows = values[0]
				return rows
				break
			end
		end
	end
	
	def columns
		datos = read_file(path)
		datos.each_line	do |line|
			if line.strip.length == 7 && line.strip =~ / /
				values = line.split(' ')
				columns = values[1]
				return columns
				break
			end
		end
	end
	
	def minelements
		datos = read_file(path)
		datos.each_line	do |line|
			if line.strip.length == 7 && line.strip =~ / /
				values = line.split(' ')
				minelements = values[2]
				return minelements
				break
			end
		end
	end
	
	def maxpieces
		datos = read_file(path)
		datos.each_line	do |line|
			if line.strip.length == 7 && line.strip =~ / /
				values = line.split(' ')
				maxpieces = values[3]
				return maxpieces
				break
			end
		end
	end
	
	def pizzapieces
		datos = read_file(path)
		@pizza = Hash.new
		maxrow = rows
		currow = 0
		maxcol = columns
		datos.each_line	do |line|
			if !line.strip.match(/\s/)
				curcol = 0
				values = line.split("")
				while curcol < maxcol.to_i
					if values[curcol] == "T"
						@pizza[[curcol,currow]] = 0
						curcol += 1
					elsif values[curcol] == "M"
						@pizza[[curcol,currow]] = 1
						curcol += 1
					else
						puts "ERROR: the value is not M or T"
						exit 1
					end
				end
			currow += 1
			end
		end
	return @pizza
	end
end







